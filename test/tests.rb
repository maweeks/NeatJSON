TESTS = [
	{value:true,  tests:[{json:"true"  }]},
	{value:false, tests:[{json:"false" }]},
	{value:nil,   tests:[{json:"null"  }]},
	{value:5,     tests:[
		{json:"5"},
		{json:"5", opts:{decimals:3}},
	]},
	{value:5.0, tests:[
		{json:"5"},
		{json:"5", opts:{decimals:3}},
	]},
	{value:5.0001, tests:[
		{json:"5.0001"},
		{json:"5.000", opts:{decimals:3}},
	]},
	{value:4.2, tests:[
		{json:"4.2"},
		{json:"4",   opts:{decimals:0}},
		{json:"4.20",opts:{decimals:2}},
	]},
	{value:4.199, tests:[{json:"4.20", opts:{decimals:2}}]},
	{value:4.204, tests:[{json:"4.20", opts:{decimals:2}}]},
	{value:-1.9,  tests:[{json:"-2",   opts:{decimals:0}}]},
	{value:-2.4,  tests:[{json:"-2",   opts:{decimals:0}}]},
	{value:1e23,  tests:[{json:/1(?:\.0+)?e\+23/i}]},
	{value:1e-9,  tests:[{json:/1(?:\.0+)?e-0*9/i}]},
	{value:-2.4,  tests:[{json:"-2",   opts:{decimals:0}}]},

	{value:"foo",       tests:[{json:"\"foo\""}]},
	{value: :foo,       tests:[{json:"\"foo\""}]},
	{value:"foo\nbar",  tests:[{json:"\"foo\\nbar\""}]},

	{value:[1,2,3,4,[5,6,7,[8,9,10],11,12]], tests:[
		{ json:"[1,2,3,4,[5,6,7,[8,9,10],11,12]]" },
		{ json:"[\n  1,\n  2,\n  3,\n  4,\n  [5,6,7,[8,9,10],11,12]\n]", opts:{wrap:30} },
		{ json:"[\n  1,\n  2,\n  3,\n  4,\n  [\n    5,\n    6,\n    7,\n    [8,9,10],\n    11,\n    12\n  ]\n]", opts:{wrap:20} },
		{ json:"[\n  1,\n  2,\n  3,\n  4,\n  [\n    5,\n    6,\n    7,\n    [\n      8,\n      9,\n      10\n    ],\n    11,\n    12\n  ]\n]", opts:{wrap:true} },
		{ json:"[\n\t1,\n\t2,\n\t3,\n\t4,\n\t[\n\t\t5,\n\t\t6,\n\t\t7,\n\t\t[\n\t\t\t8,\n\t\t\t9,\n\t\t\t10\n\t\t],\n\t\t11,\n\t\t12\n\t]\n]", opts:{wrap:true,indent:"\t"} },
		{ json:"[1,2,3,4,[5,6,7,[8,9,10],11,12]]", opts:{array_padding:0} },
		{ json:"[ 1,2,3,4,[ 5,6,7,[ 8,9,10 ],11,12 ] ]", opts:{array_padding:1} },
		{ json:"[  1,2,3,4,[  5,6,7,[  8,9,10  ],11,12  ]  ]", opts:{array_padding:2} },
		{ json:"[1, 2, 3, 4, [5, 6, 7, [8, 9, 10], 11, 12]]", opts:{after_comma:1} },
		{ json:"[ 1, 2, 3, 4, [ 5, 6, 7, [ 8, 9, 10 ], 11, 12 ] ]", opts:{after_comma:1,array_padding:1} },
		{ json:"[1,\n 2,\n 3,\n 4,\n [5,\n  6,\n  7,\n  [8,\n   9,\n   10],\n  11,\n  12]]", opts:{short:true,wrap:true} },
		{ json:"[1,\n 2,\n 3,\n 4,\n [5,\n  6,\n  7,\n  [8,\n   9,\n   10],\n  11,\n  12]]", opts:{short:true,wrap:true,after_comma:1} },
		{ json:"[ 1,\n  2,\n  3,\n  4,\n  [ 5,\n    6,\n    7,\n    [ 8,\n      9,\n      10 ],\n    11,\n    12 ] ]", opts:{short:true,wrap:true,array_padding:1} },
		{ json:"[ 1,\n  2,\n  3,\n  4,\n  [ 5,\n    6,\n    7,\n    [ 8,9,10 ],\n    11,\n    12 ] ]", opts:{short:true,wrap:true,array_padding:1, flatten_simple_arrays:true } },
	]},

	{value:[1,2,3], tests:[
		{ json:"[1,2,3]" },
		{ json:"[1 ,2 ,3]",   opts:{before_comma:1} },
		{ json:"[1 , 2 , 3]", opts:{around_comma:1} },
	]},

	{value:{b:1,a:2}, tests:[
		{ json:'{"b":1,"a":2}' },
		{ json:'{"a":2,"b":1}',                   opts:{sorted:true} },
		{ json:'{"a":2,"b":1}',                   opts:{sort:true}   },
		{ json:'{"a":2, "b":1}',                  opts:{sorted:true,after_comma:1} },
		{ json:'{"a" :2,"b" :1}',                 opts:{sorted:true,before_colon:1} },
		{ json:'{"a": 2,"b": 1}',                 opts:{sorted:true,after_colon:1} },
		{ json:'{"a" : 2,"b" : 1}',               opts:{sorted:true,before_colon:1,after_colon:1} },
		{ json:'{"a" : 2, "b" : 1}',              opts:{sorted:true,before_colon:1,after_colon:1,after_comma:1} },
		{ json:'{ "a" : 2, "b" : 1 }',            opts:{sorted:true,before_colon:1,after_colon:1,after_comma:1,padding:1} },
		{ json:'{ "a" : 2, "b" : 1 }',            opts:{sorted:true,around_colon:1,after_comma:1,object_padding:1} },
		{ json:'{"a" : 2, "b" : 1}',              opts:{sorted:true,before_colon:1,after_colon:1,after_comma:1,array_padding:1} },
		{ json:'{  "a"  :  2, "b"  :  1  }',      opts:{sorted:true,around_colon:2,after_comma:1,padding:2} },
		{ json:'{  "a":2, "b":1  }',              opts:{sorted:true,after_comma:1,padding:2} },
		{ json:'{"b":  1,"a":  2}',               opts:{after_colon_1:2} },
		{ json:'{"b"  :  1,"a"  :  2}',           opts:{around_colon_1:2} },
		{ json:"{\n  \"b\":1,\n  \"a\":2\n}",     opts:{wrap:true,around_colon_1:2} },
		{ json:"{\n  \"b\": 1,\n  \"a\": 2\n}",   opts:{wrap:true,after_colon:1} },
		{ json:"{\n  \"b\": 1,\n  \"a\": 2\n}",   opts:{wrap:true,after_colon_n:1} },
		{ json:"{\"b\":1,\n \"a\":2}",            opts:{wrap:true,short:true} },
		{ json:"{\"b\": 1,\n \"a\": 2}",          opts:{wrap:true,short:true,after_colon:1} },
		{ json:"{\"b\": 1,\n \"a\": 2}",          opts:{wrap:true,short:true,after_colon_n:1} },
		{ json:"{\"b\":1,\n \"a\":2}",            opts:{wrap:true,short:true,after_colon_1:1} },
	]},

	{value:{b:1,aaa:2,cc:3}, tests:[
		{ json:"{\n  \"b\":1,\n  \"aaa\":2,\n  \"cc\":3\n}",    opts:{wrap:true} },
		{ json:"{\n  \"b\"  :1,\n  \"aaa\":2,\n  \"cc\" :3\n}", opts:{wrap:true,aligned:true} },
		{ json:"{\"b\":1,\"aaa\":2,\"cc\":3}",                  opts:{aligned:true} },
		{ json:"{\n  \"aaa\":2,\n  \"b\"  :1,\n  \"cc\" :3\n}", opts:{wrap:true,aligned:true,sorted:true} },
	]},

	{value:{a:1}, tests:[
		{ json:'{"a":1}' },
		{ json:"{\n  \"a\":1\n}",   opts:{wrap:true} },
		{ json:"{\n  \"a\":1\n  }", opts:{wrap:true, indent_last:true} },
		{ json:"{\n \"a\":1\n }",   opts:{wrap:true, indent:" ", indent_last:true} },
	]},

	{value:{ b:17, a:42 }, tests:[
		{ json:"{\"a\":42,\n \"b\":17}", opts:{wrap:10,sorted:true,short:true} },
		{ json:"{\"a\":42,\n \"b\":17}", opts:{wrap:10,sort:true,  short:true} },
		{ json:"{\n  \"a\":42,\n  \"b\":17\n}", opts:{wrap:1,sorted:true} },
		{ json:"{\n  \"a\":42,\n  \"b\":17\n}", opts:{wrap:1,sort:true} },
		{ json:"{\"a\":42,\"b\":17}", opts:{wrap:false,sort:->(k){   k } } },
		{ json:"{\"b\":17,\"a\":42}", opts:{wrap:false,sort:->(k,v){ v } } },
		{ json:"{\"a\":42,\"b\":17}", opts:{wrap:false,sort:->(k,v){ -v } } },
		{ json:"{\"a\":42,\"b\":17}", opts:{wrap:false,sort:->(k,v,h){ v==h.values.max ? 0 : 1 } } },
		{ json:"{\n\"b\":17,\n\"a\":42\n}", opts:{wrap:1,indent:"",sort:->(k,v){ k==:a ? 1 : 0 } } },
		{ json:"{\n\"a\":42,\n\"b\":17\n}", opts:{wrap:1,indent:"",sort:->(k,v){ k==:a ? 0 : 1 } } },
	]},

	{value:[1,{a:2},3], tests:[
		{ json:'[1,{"a":2},3]' },
		{ json:'[ 1,{ "a":2 },3 ]',                       opts:{padding:1} },
		{ json:'[ 1, { "a":2 }, 3 ]',                     opts:{padding:1,after_comma:1} },
		{ json:"[\n  1,\n  {\n    \"a\":2\n  },\n  3\n]", opts:{wrap:true} },
		{ json:"[\n  1,\n  {\"a\":2},\n  3\n]",           opts:{wrap:10} },
		{ json:"[\n  1,\n  {\n    \"a\":2\n    },\n  3\n  ]", opts:{wrap:true,indent_last:true} },
	]},

	{value:[1,{a:2,b:3},4], tests:[
		{ json:"[1,\n {\"a\":2,\n  \"b\":3},\n 4]", opts:{wrap:0,short:true} },
	]},

	{value:{a:1,b:[2,3,4],c:3}, tests:[
		{ json:'{"a":1,"b":[2,3,4],"c":3}' },
		{ json:"{\n  \"a\":1,\n  \"b\":[2,3,4],\n  \"c\":3\n}",                           opts:{wrap:10} },
		{ json:"{\n  \"a\":1,\n  \"b\":[\n    2,\n    3,\n    4\n  ],\n  \"c\":3\n}",     opts:{wrap:true} },
		{ json:"{\n  \"a\":1,\n  \"b\":[\n    2,\n    3,\n    4\n    ],\n  \"c\":3\n  }", opts:{wrap:true,indent_last:true} },
	]},

	{value:{hooo:42,whee:['yaaa','oooo','booy'],zoop:"whoop"}, tests:[
		{ json:"{\"hooo\":42,\n \"whee\":[\"yaaa\",\n         \"oooo\",\n         \"booy\"],\n \"zoop\":\"whoop\"}", opts:{wrap:20,short:true} },
	]},

	{value:{ a:[ {x:"foo",y:"jim"}, {x:"bar",y:"jam"} ] }, tests:[
		{ json:"{\"a\":[{\"x\":\"foo\",\n       \"y\":\"jim\"},\n      {\"x\":\"bar\",\n       \"y\":\"jam\"}]}", opts:{wrap:true,short:true} },
	]},

	{value:{"abcdefghij"=>[{"abcdefghijklmnop"=>{}}]}, tests:[
		{ json:"{\"abcdefghij\":[{\"abcdefghijklmnop\":{}}]}" },
		{ json:"{\"abcdefghij\" : [{\"abcdefghijklmnop\" : {}}]}", opts:{wrap:1, short:true, around_colon_n:1} },
	]},

	{value:{foo:{}}, tests:[
		{ json:"{\"foo\":{}}" },
		{ json:"{\"foo\":{}}",        opts:{wrap:false} },
		{ json:"{\n  \"foo\":{}\n}",  opts:{wrap:5}    },
		{ json:"{\"foo\":{}}",        opts:{wrap:1, short:true} },
	]},

	{value:["foo",{},"bar"], tests:[
		{ json:"[\n  \"foo\",\n  {},\n  \"bar\"\n]",  opts:{wrap:1} },
		{ json:"[\"foo\",\n {},\n \"bar\"]",          opts:{wrap:1, short:true} },
	]},

	{value:["foo",[],"bar"], tests:[
		{ json:"[\n  \"foo\",\n  [],\n  \"bar\"\n]",  opts:{wrap:1} },
		{ json:"[\"foo\",\n [],\n \"bar\"]",          opts:{wrap:1, short:true} },
	]},

	{value:["foo",[{},[{foo:[]},42]],"bar"], tests:[
		{ json:"[\"foo\",\n [{},\n  [{\"foo\":[]},\n   42]],\n \"bar\"]",  opts:{wrap:1, short:true} },
	]},

	{value:Class.new{ def to_json(*a); {a:1}.to_json(*a); end }.new, tests:[
		{ json:'{  "a":1}' },
		{ json:'{  "a":1}', opts:{wrap:true} },
		{ json:'{"a":1}',   opts:{indent:''} },
	]},

	{value:Class.new{ def to_json(*a); JSON.neat_generate({a:1},*a); end }.new, tests:[
		{ json:'{"a":1}' },
		{ json:"{\n  \"a\":1\n}", opts:{wrap:true} },
	]},

	{value:{a:{b:{c:{d:{e:{f:{g:{h:{i:{j:{k:{l:{m:1}}}}}}}}}}}}}, tests:[
		{ json:'{"a":{"b":{"c":{"d":{"e":{"f":{"g":{"h":{"i":{"j":{"k":{"l":{"m":1}}}}}}}}}}}}}', opts:{wrap:false} },
		{ json:'{"a":{"b":{"c":{"d":{"e":{"f":{"g":{"h":{"i":{"j":{"k":{"l":{"m":1}}}}}}}}}}}}}', opts:{wrap:1,short:true} },
		{ json:"{\n  \"a\":{\n    \"b\":{\n      \"c\":{\n        \"d\":{\n          \"e\":{\n            \"f\":{\n              \"g\":{\n                \"h\":{\n                  \"i\":{\n                    \"j\":{\n                      \"k\":{\n                        \"l\":{\n                          \"m\":1\n                        }\n                      }\n                    }\n                  }\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  }\n}", opts:{wrap:1} },
	]},

	# Issue #27
	{value:{'b'=>2, a:1}, tests:[
		{json:'{"b":2,"a":1}', opts:{wrap:false}},
		{json:'{"a":1,"b":2}', opts:{wrap:false, sort:->(k){k.to_s}}},
		{json:'{"a":1,"b":2}', opts:{wrap:false, sort:->(k,v){k.to_s}}},
		{json:'{"a":1,"b":2}', opts:{wrap:false, sort:->(k,v,o){k.to_s}}},
		{json:'{"a":1,"b":2}', opts:{wrap:false, sort:true}},
	]},
]
