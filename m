Sender: Joe Nall <joenall@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Exposing secid to secctx mapping to user-space
From: Joe Nall <joe@nall.com>
In-Reply-To: <56703A9E.7000507@schaufler-ca.com>
Date: Tue, 15 Dec 2015 11:19:34 -0600
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 Paul Moore <paul@paul-moore.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "arve@google.com" <arve@google.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>
Message-Id: <E542E1EE-77B3-4133-B9AC-486256AB7D53@nall.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
 <56702B25.9010205@tycho.nsa.gov> <56703A9E.7000507@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> On Dec 15, 2015, at 10:06 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> ...
> I have long wondered why SELinux generates the context string
> of the secid more than once. Audit performance alone would
> justify keeping it around. The variable length issue isn't
> so difficult as you make it out. As William pointed out earlier,
> most SELinux contexts are short. Two protocols, one with a
> fixed length of 16 chars (typical is 7) and one with a fixed
> length of 256 (for abnormal contexts) solve the problem without
> complicating the code hardly at all.

We have 'abnormal' contexts over 1024 bytes in production MLS systems. It is possible, though unlikely, to see raw contexts over 5k bytes with 1024 category bits. Thinking like this broke the original RHEL 5 racoon and more recently RHEL 6 openswan for us.

joe

system_u:system_r:silly_test_t:s2:c0,c2,c4,c6,c8,c10,c12,c14,c16,c18,c20,c22,c24,c26,c28,c30,c32,c34,c36,c38,c40,c42,c44,c46,c48,c50,c52,c54,c56,c58,c60,c62,c64,c66,c68,c70,c72,c74,c76,c78,c80,c82,c84,c86,c88,c90,c92,c94,c96,c98,c100,c102,c104,c106,c108,c110,c112,c114,c116,c118,c120,c122,c124,c126,c128,c130,c132,c134,c136,c138,c140,c142,c144,c146,c148,c150,c152,c154,c156,c158,c160,c162,c164,c166,c168,c170,c172,c174,c176,c178,c180,c182,c184,c186,c188,c190,c192,c194,c196,c198,c200,c202,c204,c206,c208,c210,c212,c214,c216,c218,c220,c222,c224,c226,c228,c230,c232,c234,c236,c238,c240,c242,c244,c246,c248,c250,c252,c254,c256,c258,c260,c262,c264,c266,c268,c270,c272,c274,c276,c278,c280,c282,c284,c286,c288,c290,c292,c294,c296,c298,c300,c302,c304,c306,c308,c310,c312,c314,c316,c318,c320,c322,c324,c326,c328,c330,c332,c334,c336,c338,c340,c342,c344,c346,c348,c350,c352,c354,c356,c358,c360,c362,c364,c366,c368,c370,c372,c374,c376,c378,c380,c382,c384,c386,c388,c390,c392,c394,c396,c398,c400,c402,c404,c406,c408,c410,c412,c414,c416,c418,c420,c422,c424,c426,c428,c430,c432,c434,c436,c438,c440,c442,c444,c446,c448,c450,c452,c454,c456,c458,c460,c462,c464,c466,c468,c470,c472,c474,c476,c478,c480,c482,c484,c486,c488,c490,c492,c494,c496,c498,c500,c502,c504,c506,c508,c510,c512,c514,c516,c518,c520,c522,c524,c526,c528,c530,c532,c534,c536,c538,c540,c542,c544,c546,c548,c550,c552,c554,c556,c558,c560,c562,c564,c566,c568,c570,c572,c574,c576,c578,c580,c582,c584,c586,c588,c590,c592,c594,c596,c598,c600,c602,c604,c606,c608,c610,c612,c614,c616,c618,c620,c622,c624,c626,c628,c630,c632,c634,c636,c638,c640,c642,c644,c646,c648,c650,c652,c654,c656,c658,c660,c662,c664,c666,c668,c670,c672,c674,c676,c678,c680,c682,c684,c686,c688,c690,c692,c694,c696,c698,c700,c702,c704,c706,c708,c710,c712,c714,c716,c718,c720,c722,c724,c726,c728,c730,c732,c734,c736,c738,c740,c742,c744,c746,c748,c750,c752,c754,c756,c758,c760,c762,c764,c766,c768,c770,c772,c774,c776,c778,c780,c782,c784,c786,c788,c790,c792,c794,c796,c798,c800,c802,c804,c806,c808,c810,c812,c814,c816,c818,c820,c822,c824,c826,c828,c830,c832,c834,c836,c838,c840,c842,c844,c846,c848,c850,c852,c854,c856,c858,c860,c862,c864,c866,c868,c870,c872,c874,c876,c878,c880,c882,c884,c886,c888,c890,c892,c894,c896,c898,c900,c902,c904,c906,c908,c910,c912,c914,c916,c918,c920,c922,c924,c926,c928,c930,c932,c934,c936,c938,c940,c942,c944,c946,c948,c950,c952,c954,c956,c958,c960,c962,c964,c966,c968,c970,c972,c974,c976,c978,c980,c982,c984,c986,c988,c990,c992,c994,c996,c998,c1000,c1002,c1004,c1006,c1008,c1010,c1012,c1014,c1016,c1018,c1020,c1022:s2:c0,c2,c4,c6,c8,c10,c12,c14,c16,c18,c20,c22,c24,c26,c28,c30,c32,c34,c36,c38,c40,c42,c44,c46,c48,c50,c52,c54,c56,c58,c60,c62,c64,c66,c68,c70,c72,c74,c76,c78,c80,c82,c84,c86,c88,c90,c92,c94,c96,c98,c100,c102,c104,c106,c108,c110,c112,c114,c116,c118,c120,c122,c124,c126,c128,c130,c132,c134,c136,c138,c140,c142,c144,c146,c148,c150,c152,c154,c156,c158,c160,c162,c164,c166,c168,c170,c172,c174,c176,c178,c180,c182,c184,c186,c188,c190,c192,c194,c196,c198,c200,c202,c204,c206,c208,c210,c212,c214,c216,c218,c220,c222,c224,c226,c228,c230,c232,c234,c236,c238,c240,c242,c244,c246,c248,c250,c252,c254,c256,c258,c260,c262,c264,c266,c268,c270,c272,c274,c276,c278,c280,c282,c284,c286,c288,c290,c292,c294,c296,c298,c300,c302,c304,c306,c308,c310,c312,c314,c316,c318,c320,c322,c324,c326,c328,c330,c332,c334,c336,c338,c340,c342,c344,c346,c348,c350,c352,c354,c356,c358,c360,c362,c364,c366,c368,c370,c372,c374,c376,c378,c380,c382,c384,c386,c388,c390,c392,c394,c396,c398,c400,c402,c404,c406,c408,c410,c412,c414,c416,c418,c420,c422,c424,c426,c428,c430,c432,c434,c436,c438,c440,c442,c444,c446,c448,c450,c452,c454,c456,c458,c460,c462,c464,c466,c468,c470,c472,c474,c476,c478,c480,c482,c484,c486,c488,c490,c492,c494,c496,c498,c500,c502,c504,c506,c508,c510,c512,c514,c516,c518,c520,c522,c524,c526,c528,c530,c532,c534,c536,c538,c540,c542,c544,c546,c548,c550,c552,c554,c556,c558,c560,c562,c564,c566,c568,c570,c572,c574,c576,c578,c580,c582,c584,c586,c588,c590,c592,c594,c596,c598,c600,c602,c604,c606,c608,c610,c612,c614,c616,c618,c620,c622,c624,c626,c628,c630,c632,c634,c636,c638,c640,c642,c644,c646,c648,c650,c652,c654,c656,c658,c660,c662,c664,c666,c668,c670,c672,c674,c676,c678,c680,c682,c684,c686,c688,c690,c692,c694,c696,c698,c700,c702,c704,c706,c708,c710,c712,c714,c716,c718,c720,c722,c724,c726,c728,c730,c732,c734,c736,c738,c740,c742,c744,c746,c748,c750,c752,c754,c756,c758,c760,c762,c764,c766,c768,c770,c772,c774,c776,c778,c780,c782,c784,c786,c788,c790,c792,c794,c796,c798,c800,c802,c804,c806,c808,c810,c812,c814,c816,c818,c820,c822,c824,c826,c828,c830,c832,c834,c836,c838,c840,c842,c844,c846,c848,c850,c852,c854,c856,c858,c860,c862,c864,c866,c868,c870,c872,c874,c876,c878,c880,c882,c884,c886,c888,c890,c892,c894,c896,c898,c900,c902,c904,c906,c908,c910,c912,c914,c916,c918,c920,c922,c924,c926,c928,c930,c932,c934,c936,c938,c940,c942,c944,c946,c948,c950,c952,c954,c956,c958,c960,c962,c964,c966,c968,c970,c972,c974,c976,c978,c980,c982,c984,c986,c988,c990,c992,c994,c996,c998,c1000,c1002,c1004,c1006,c1008,c1010,c1012,c1014,c1016,c1018,c1020.c1022
