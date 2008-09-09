Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m89GG6Y6023249
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 12:16:06 -0400
Received: from goalkeeper.city-fan.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m89GFIl6013152
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 16:15:19 GMT
Message-ID: <48C6A124.7090707@city-fan.org>
Date: Tue, 09 Sep 2008 17:15:32 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Milter Mail Filters
References: <484D4B53.5020006@city-fan.org>	 <1216385922.21191.125.camel@gorn>  <48982587.30605@city-fan.org> <1220621188.28287.79.camel@gorn.columbia.tresys.com>
In-Reply-To: <1220621188.28287.79.camel@gorn.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------050805090009030300020309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050805090009030300020309
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Tue, 2008-08-05 at 11:03 +0100, Paul Howarth wrote:
>> Christopher J. PeBenito wrote:
>>> On Mon, 2008-06-09 at 16:25 +0100, Paul Howarth wrote:
>>>> attached is a patch based on local policy I'm using on Fedora 9 to 
>>>> support two "milter" mail filter daemons in conjunction with
>>>> sendmail, 
>>>> namely spamass-milter and milter-regex (I maintain the packages for
>>>> both 
>>>> of these in Fedora).
>>>>
>>>> I've taken the view that most milter applications will have similar 
>>>> requirements and so I've created a milter_template interface that 
>>>> contains most of what's needed, and then added the specifics that are 
>>>> needed on top of the generic stuff for each application.
> 
>>>> +#============= milter-regex policy ==============
>>>> +milter_template(regex)
>>> As I mentioned before, it doesn't look like a template is needed, unless
>>> you think there will be many more milter domains.  Then put all the
>>> declarations in a section.
>> There are plenty of milters out there - see http://www.milter.org/milters
>>
>> Not sure what you mean by "put all the declarations in a section". The 
>> current version has very few declarations anyway now.
> 
> The style (including the commenting style) needs to match the rest of
> refpolicy.  If you're invoking a template like this, it means there are
> some declarations.  Other refpolicy modules have calls like this in the
> declarations section.

OK, template invocations moved and commenting style revised.

>>>> +interface(`milter_spamass_stream_connect',`
>>>> +       gen_require(`
>>>> +               type milter_spamass_var_run_t, milter_spamass_t;
>>>> +       ')
>>>> +       stream_connect_pattern($1,milter_spamass_var_run_t,milter_spamass_var_run_t,milter_spamass_t)
>>>> +')
>>>> +
>>> Missing a files_search_spool().  Interface name needs to be fixed [1].
>> I have two interfaces now, common to all milters:
>>
>> milter_stream_connect
>> milter_getattr_socket_dir
>>
>> I'll try claiming that "milter" is an abbreviation of "milters"; any 
>> suggestions for better predicate names?
> 
> The target domain/object name, eg. milter_stream_connect_regex()
> 
>> I'm now using milter_$1_data_dir_t in the interface, where this 
>> directory might live under /var/spool for some milters, /var/run for 
>> others etc. So I added files_search_spool() in the te file for the 
>> milter(s) that needed it (only).
> 
> It seems that milter_$1_data_dir_t and milter_$1_socket_t can be merged
> into milter_$1_data_t.  They're all objects in the data dir, with
> different classes.  The object class differentiation should be
> sufficient IMO.

OK, I've done this now. I originally split this up so that if a milter 
wanted to create some other socket other than the one it used to 
communicate with the MTA, then it would get a different context type. Of 
course, if that happens, it's just as easy for the milter-specific 
policy to arrange for a different context type to be used.

>> Heavily revised patch attached. The individual milter policies are quite 
>> brief now (and there are plenty more that could be added), which I think 
>> justifies the template approach. No further changes should need to be 
>> made to the sendmail and postfix policies to support additional milters 
>> either.
> 
> The main thing that worries me about template usage is too many rules
> going into them just for convenience.  We don't want rules that aren't
> common to all milters.

I've removed more of the stuff from policygentool and kept the stuff I 
really think is necessary now.

>> plain text document attachment (milters.patch)
> [...]
>> --- policy/modules/services/milters.te	(revision 0)
>> +++ policy/modules/services/milters.te	(revision 0)
>> @@ -0,0 +1,42 @@
>> +policy_module(milters,0.1.4)
>> +
>> +require {
>> +	attribute port_type;
>> +}
> 
> This should be removed.

Done.

>> +#============= declarations ================
> 
> The commenting style needs to be fixed.

Done.

> [...]
>> +interface(`milter_stream_connect',`
>> +	gen_require(`
>> +		attribute milter_socket_directories, milter_socket_type, milter_domains;
>> +	')
>> +	getattr_dirs_pattern($1,milter_socket_directories,milter_socket_directories)
>> +	stream_connect_pattern($1,milter_socket_directories,milter_socket_type,milter_domains)
>> +')
> 
> Needs to be named so that it shows that you can connect to all milters:
> milter_stream_connect_all()

Done.

Revised patch attached.

Paul.

--------------050805090009030300020309
Content-Type: text/plain;
 name="milters.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="milters.patch"

SW5kZXg6IHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9rZXJuZWwvY29yZW5ldHdvcmsudGUu
aW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQotLS0gcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL2tlcm5lbC9j
b3JlbmV0d29yay50ZS5pbgkocmV2aXNpb24gMjgwMCkKKysrIHJlZnBvbGljeS9wb2xpY3kv
bW9kdWxlcy9rZXJuZWwvY29yZW5ldHdvcmsudGUuaW4JKHdvcmtpbmcgY29weSkKQEAgLTEy
MSw2ICsxMjEsNyBAQAogdHlwZSBscnJkX3BvcnRfdCwgcG9ydF90eXBlOyBkbmwgbmV0d29y
a19wb3J0KGxycmRfcG9ydF90KSAjIG5vIGRlZmluZWQgcG9ydGNvbgogbmV0d29ya19wb3J0
KGxtdHAsIHRjcCwyNCxzMCwgdWRwLDI0LHMwKQogbmV0d29ya19wb3J0KG1haWwsIHRjcCwy
MDAwLHMwKQordHlwZSBtaWx0ZXJfcG9ydF90LCBwb3J0X3R5cGU7IGRubCBuZXR3b3JrX3Bv
cnQobWlsdGVyKSAjIG5vIGRlZmluZWQgcG9ydGNvbgogbmV0d29ya19wb3J0KG1tY2MsIHRj
cCw1MDUwLHMwLCB1ZHAsNTA1MCxzMCkKIG5ldHdvcmtfcG9ydChtb25vcGQsIHRjcCwxMjM0
LHMwKQogbmV0d29ya19wb3J0KG1zbnAsIHRjcCwxODYzLHMwLCB1ZHAsMTg2MyxzMCkKSW5k
ZXg6IHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9taWx0ZXJzLnRlCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KLS0tIHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9taWx0ZXJz
LnRlCShyZXZpc2lvbiAwKQorKysgcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3NlcnZpY2Vz
L21pbHRlcnMudGUJKHJldmlzaW9uIDApCkBAIC0wLDAgKzEsNTQgQEAKK3BvbGljeV9tb2R1
bGUobWlsdGVycywwLjIuMCkKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIworIworIyBEZWNsYXJhdGlvbnMKKyMKKworIyBhdHRyaWJ1dGVzIGNvbW1vbiB0
byBhbGwgbWlsdGVycworYXR0cmlidXRlIG1pbHRlcl9kb21haW5zOworYXR0cmlidXRlIG1p
bHRlcl9kYXRhX3R5cGU7CisKKyMgY3VycmVudGx5LXN1cHBvcnRlZCBtaWx0ZXJzIGFyZSBt
aWx0ZXItcmVnZXggYW5kIHNwYW1hc3MtbWlsdGVyCittaWx0ZXJfdGVtcGxhdGUocmVnZXgp
CittaWx0ZXJfdGVtcGxhdGUoc3BhbWFzcykKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIworIworIyBtaWx0ZXItcmVnZXggbG9jYWwgcG9saWN5CisjICAg
ZmlsdGVyIGVtYWlscyB1c2luZyByZWd1bGFyIGV4cHJlc3Npb25zCisjICAgaHR0cDovL3d3
dy5iZW56ZWRyaW5lLmN4L21pbHRlci1yZWdleC5odG1sCisjCisKKyMgTG9vayB1cCB1c2Vy
bmFtZSBmb3IgZHJvcHBpbmcgcHJpdnMKK2F1dGhfdXNlX25zc3dpdGNoKG1pbHRlcl9yZWdl
eF90KQorCisjIENvbmZpZyBpcyBpbiAvZXRjL21haWwvbWlsdGVyLXJlZ2V4LmNvbmYKK210
YV9yZWFkX2NvbmZpZyhtaWx0ZXJfcmVnZXhfdCkKKworIyBUaGUgbWlsdGVyJ3Mgc29ja2V0
IGRpcmVjdG9yeSBsaXZlcyB1bmRlciAvdmFyL3Nwb29sCitmaWxlc19zZWFyY2hfc3Bvb2wo
bWlsdGVyX3JlZ2V4X3QpCisKKyMgSXQgcmVtb3ZlcyBhbnkgZXhpc3Rpbmcgc29ja2V0IChu
b3Qgb3duZWQgYnkgcm9vdCkgd2hpbHN0IHJ1bm5pbmcgYXMgcm9vdAorIyBhbmQgdGhlbiBj
YWxscyBzZXRnaWQoKSBhbmQgc2V0dWlkKCkgdG8gZHJvcCBwcml2aWxlZ2VzCithbGxvdyBt
aWx0ZXJfcmVnZXhfdCBzZWxmOmNhcGFiaWxpdHkgeyBzZXR1aWQgc2V0Z2lkIGRhY19vdmVy
cmlkZSB9OworCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
KyMKKyMgc3BhbWFzcy1taWx0ZXIgbG9jYWwgcG9saWN5CisjICAgcGlwZSBlbWFpbHMgdGhy
b3VnaCBTcGFtQXNzYXNzaW4KKyMgICBodHRwOi8vc2F2YW5uYWgubm9uZ251Lm9yZy9wcm9q
ZWN0cy9zcGFtYXNzLW1pbHQvCisjCisKKyMgVGhlIG1haW4gam9iIG9mIHRoZSBtaWx0ZXIg
aXMgdG8gcGlwZSBzcGFtIHRocm91Z2ggc3BhbWMgYW5kIGFjdCBvbiB0aGUgcmVzdWx0Citz
cGFtYXNzYXNzaW5fZG9tdHJhbnNfc3BhbWMobWlsdGVyX3NwYW1hc3NfdCkKKworIyBXaGVu
IHVzZWQgd2l0aCAtYiBvciAtQiBvcHRpb25zLCB0aGUgbWlsdGVyIGludm9rZXMgc2VuZG1h
aWwgdG8gc2VuZCBtYWlsCisjIHRvIGEgc3BhbXRyYXAgYWRkcmVzcywgdXNpbmcgcG9wZW4o
KQorY29yZWNtZF9leGVjX3NoZWxsKG1pbHRlcl9zcGFtYXNzX3QpCitjb3JlY21kX3JlYWRf
YmluX3N5bWxpbmtzKG1pbHRlcl9zcGFtYXNzX3QpCitjb3JlY21kX3NlYXJjaF9iaW4obWls
dGVyX3NwYW1hc3NfdCkKK2tlcm5lbF9yZWFkX3N5c3RlbV9zdGF0ZShtaWx0ZXJfc3BhbWFz
c190KQorbXRhX3NlbmRfbWFpbChtaWx0ZXJfc3BhbWFzc190KQorCkluZGV4OiByZWZwb2xp
Y3kvcG9saWN5L21vZHVsZXMvc2VydmljZXMvc2VuZG1haWwudGUKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3NlbmRtYWlsLnRlCShyZXZp
c2lvbiAyODAwKQorKysgcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3NlbmRt
YWlsLnRlCSh3b3JraW5nIGNvcHkpCkBAIC0xMTIsNiArMTEyLDEwIEBACiAnKQogCiBvcHRp
b25hbF9wb2xpY3koYAorCW1pbHRlcl9zdHJlYW1fY29ubmVjdF9hbGwoc2VuZG1haWxfdCkK
KycpCisKK29wdGlvbmFsX3BvbGljeShgCiAJcG9zdGZpeF9leGVjX21hc3RlcihzZW5kbWFp
bF90KQogCXBvc3RmaXhfcmVhZF9jb25maWcoc2VuZG1haWxfdCkKIAlwb3N0Zml4X3NlYXJj
aF9zcG9vbChzZW5kbWFpbF90KQpJbmRleDogcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3Nl
cnZpY2VzL21pbHRlcnMuZmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gcmVmcG9saWN5L3BvbGljeS9t
b2R1bGVzL3NlcnZpY2VzL21pbHRlcnMuZmMJKHJldmlzaW9uIDApCisrKyByZWZwb2xpY3kv
cG9saWN5L21vZHVsZXMvc2VydmljZXMvbWlsdGVycy5mYwkocmV2aXNpb24gMCkKQEAgLTAs
MCArMSw3IEBACisvdXNyL3NiaW4vbWlsdGVyLXJlZ2V4CQkJCS0tCWdlbl9jb250ZXh0KHN5
c3RlbV91Om9iamVjdF9yOm1pbHRlcl9yZWdleF9leGVjX3QsczApCisvdmFyL3Nwb29sL21p
bHRlci1yZWdleCgvLiopPwkJCQlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3RfcjptaWx0
ZXJfcmVnZXhfZGF0YV90LHMwKQorCisvdXNyL3NiaW4vc3BhbWFzcy1taWx0ZXIJCQktLQln
ZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3RfcjptaWx0ZXJfc3BhbWFzc19leGVjX3QsczAp
CisvdmFyL3J1bi9zcGFtYXNzLW1pbHRlcigvLiopPwkJCQlnZW5fY29udGV4dChzeXN0ZW1f
dTpvYmplY3RfcjptaWx0ZXJfc3BhbWFzc19kYXRhX3QsczApCisvdmFyL3J1bi9zcGFtYXNz
LW1pbHRlclwucGlkCQkJLS0JZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6bWlsdGVy
X3NwYW1hc3NfZGF0YV90LHMwKQorCkluZGV4OiByZWZwb2xpY3kvcG9saWN5L21vZHVsZXMv
c2VydmljZXMvbXRhLnRlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHJlZnBvbGljeS9wb2xpY3kvbW9k
dWxlcy9zZXJ2aWNlcy9tdGEudGUJKHJldmlzaW9uIDI4MDApCisrKyByZWZwb2xpY3kvcG9s
aWN5L21vZHVsZXMvc2VydmljZXMvbXRhLnRlCSh3b3JraW5nIGNvcHkpCkBAIC0xMDUsNiAr
MTA1LDkgQEAKIAkjIHBvc3RmaXggbmVlZHMgdGhpcyBmb3IgbmV3YWxpYXNlcwogCWZpbGVz
X2dldGF0dHJfdG1wX2RpcnMoc3lzdGVtX21haWxfdCkKIAorCSMgbmV3YWxpYXNlcyBydW5z
IGFzIHN5c3RlbV9tYWlsX3Qgd2hlbiB0aGUgc2VuZG1haWwgaW5pdHNjcmlwdCBkb2VzIGEg
cmVzdGFydAorCW1pbHRlcl9nZXRhdHRyX2FsbF9kYXRhX2RpcnMoc3lzdGVtX21haWxfdCkK
KwogCXBvc3RmaXhfZXhlY19tYXN0ZXIoc3lzdGVtX21haWxfdCkKIAlwb3N0Zml4X3JlYWRf
Y29uZmlnKHN5c3RlbV9tYWlsX3QpCiAJcG9zdGZpeF9zZWFyY2hfc3Bvb2woc3lzdGVtX21h
aWxfdCkKSW5kZXg6IHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9taWx0ZXJz
LmlmCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNl
cy9taWx0ZXJzLmlmCShyZXZpc2lvbiAwKQorKysgcmVmcG9saWN5L3BvbGljeS9tb2R1bGVz
L3NlcnZpY2VzL21pbHRlcnMuaWYJKHJldmlzaW9uIDApCkBAIC0wLDAgKzEsOTAgQEAKKyMj
IDxzdW1tYXJ5Pk1pbHRlciBtYWlsIGZpbHRlcnM8L3N1bW1hcnk+CisKKyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKKyMjIDxzdW1tYXJ5PgorIyMJQ3JlYXRl
IGEgc2V0IG9mIGRlcml2ZWQgdHlwZXMgZm9yIHZhcmlvdXMKKyMjCW1haWwgZmlsdGVyIGFw
cGxpY2F0aW9ucyB1c2luZyB0aGUgbWlsdGVyIGludGVyZmFjZS4KKyMjIDwvc3VtbWFyeT4K
KyMjIDxwYXJhbSBuYW1lPSJtaWx0ZXJfbmFtZSI+CisjIwk8c3VtbWFyeT4KKyMjCVRoZSBu
YW1lIHRvIGJlIHVzZWQgZm9yIGRlcml2aW5nIHR5cGUgbmFtZXMuCisjIwk8L3N1bW1hcnk+
CisjIyA8L3BhcmFtPgorIwordGVtcGxhdGUoYG1pbHRlcl90ZW1wbGF0ZScsYAorCisJIyBh
dHRyaWJ1dGVzIGNvbW1vbiB0byBhbGwgbWlsdGVycywgcGx1cyBwb3J0IHR5cGUgZm9yIG1p
bHRlciBUQ1Agc29ja2V0cworCWdlbl9yZXF1aXJlKGAKKwkJYXR0cmlidXRlIG1pbHRlcl9k
YXRhX3R5cGUsIG1pbHRlcl9kb21haW5zOworCQl0eXBlIG1pbHRlcl9wb3J0X3Q7CisJJykK
KworCSMgVHlwZSB0aGF0IHRoZSBtaWx0ZXIgYXBwbGljYXRpb24gcnVucyBhcworCXR5cGUg
bWlsdGVyXyQxX3QsIG1pbHRlcl9kb21haW5zOworCWRvbWFpbl90eXBlKG1pbHRlcl8kMV90
KQorCXJvbGUgc3lzdGVtX3IgdHlwZXMgbWlsdGVyXyQxX3Q7CisKKwkjIFR5cGUgZm9yIHRo
ZSBleGVjdXRhYmxlIGZpbGUKKwl0eXBlIG1pbHRlcl8kMV9leGVjX3Q7CisJaW5pdF9kYWVt
b25fZG9tYWluKG1pbHRlcl8kMV90LCBtaWx0ZXJfJDFfZXhlY190KQorCisJIyBUeXBlIGZv
ciB0aGUgbWlsdGVyIGRhdGEgKGUuZy4gdGhlIHNvY2tldCB1c2VkIHRvIGNvbW11bmljYXRl
IHdpdGggdGhlIE1UQSkKKwl0eXBlIG1pbHRlcl8kMV9kYXRhX3QsIG1pbHRlcl9kYXRhX3R5
cGU7CisJZmlsZXNfdHlwZShtaWx0ZXJfJDFfZGF0YV90KTsKKworCSMgQWxsb3cgY29tbXVu
aWNhdGlvbiB3aXRoIE1UQSBvdmVyIGEgVENQIHNvY2tldAorCWFsbG93IG1pbHRlcl8kMV90
IG1pbHRlcl9wb3J0X3Q6dGNwX3NvY2tldCBuYW1lX2JpbmQ7CisJY29yZW5ldF90Y3BfYmlu
ZF9nZW5lcmljX25vZGUobWlsdGVyXyQxX3QpCisJYWxsb3cgbWlsdGVyXyQxX3Qgc2VsZjp0
Y3Bfc29ja2V0IHsgbGlzdGVuIGFjY2VwdCB9OworCisJIyBBbGxvdyBjb21tdW5pY2F0aW9u
IHdpdGggTVRBIG92ZXIgYSB1bml4LWRvbWFpbiBzb2NrZXQKKwltYW5hZ2Vfc29ja19maWxl
c19wYXR0ZXJuKG1pbHRlcl8kMV90LG1pbHRlcl8kMV9kYXRhX3QsbWlsdGVyXyQxX2RhdGFf
dCkKKworCSMgQ3JlYXRlIG90aGVyIGRhdGEgZmlsZXMgYW5kIGRpcmVjdG9yaWVzIGluIHRo
ZSBkYXRhIGRpcmVjdG9yeQorCW1hbmFnZV9maWxlc19wYXR0ZXJuKG1pbHRlcl8kMV90LG1p
bHRlcl8kMV9kYXRhX3QsbWlsdGVyXyQxX2RhdGFfdCkKKworCSMgVGhpbmdzIHRoYXQgYWxs
KD8pIG1pbHRlcnMgd2lsbCBuZWVkIHRvIGRvCisJbGlic191c2VfbGRfc28obWlsdGVyXyQx
X3QpCisJbGlic191c2Vfc2hhcmVkX2xpYnMobWlsdGVyXyQxX3QpCisJbWlzY2ZpbGVzX3Jl
YWRfbG9jYWxpemF0aW9uKG1pbHRlcl8kMV90KQorCWluaXRfdXNlX2ZkcyhtaWx0ZXJfJDFf
dCkKKwlhbGxvdyBtaWx0ZXJfJDFfdCBzZWxmOmZpZm9fZmlsZSByd19maWZvX2ZpbGVfcGVy
bXM7CisJbG9nZ2luZ19zZW5kX3N5c2xvZ19tc2cobWlsdGVyXyQxX3QpCisKKycpCisKKyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKKyMjIDxzdW1tYXJ5Pgor
IyMJTVRBIGNvbW11bmljYXRpb24gd2l0aCBtaWx0ZXIgc29ja2V0cworIyMgPC9zdW1tYXJ5
PgorIyMgPHBhcmFtIG5hbWU9ImRvbWFpbiI+CisjIwk8c3VtbWFyeT4KKyMjCURvbWFpbiBh
bGxvd2VkIGFjY2Vzcy4KKyMjCTwvc3VtbWFyeT4KKyMjIDwvcGFyYW0+CisjCitpbnRlcmZh
Y2UoYG1pbHRlcl9zdHJlYW1fY29ubmVjdF9hbGwnLGAKKwlnZW5fcmVxdWlyZShgCisJCWF0
dHJpYnV0ZSBtaWx0ZXJfZGF0YV90eXBlLCBtaWx0ZXJfZG9tYWluczsKKwknKQorCWdldGF0
dHJfZGlyc19wYXR0ZXJuKCQxLG1pbHRlcl9kYXRhX3R5cGUsbWlsdGVyX2RhdGFfdHlwZSkK
KwlzdHJlYW1fY29ubmVjdF9wYXR0ZXJuKCQxLG1pbHRlcl9kYXRhX3R5cGUsbWlsdGVyX2Rh
dGFfdHlwZSxtaWx0ZXJfZG9tYWlucykKKycpCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKKyMjIDxzdW1tYXJ5PgorIyMJQWxsb3cgc2VhcmNoIG9mIG1p
bHRlciBkYXRhIGRpcmVjdG9yeQorIyMgPC9zdW1tYXJ5PgorIyMgPHBhcmFtIG5hbWU9ImRv
bWFpbiI+CisjIwk8c3VtbWFyeT4KKyMjCURvbWFpbiBhbGxvd2VkIGFjY2Vzcy4KKyMjCTwv
c3VtbWFyeT4KKyMjIDwvcGFyYW0+CisjCitpbnRlcmZhY2UoYG1pbHRlcl9nZXRhdHRyX2Fs
bF9kYXRhX2RpcnMnLGAKKwlnZW5fcmVxdWlyZShgCisJCWF0dHJpYnV0ZSBtaWx0ZXJfZGF0
YV90eXBlOworCScpCisJZ2V0YXR0cl9kaXJzX3BhdHRlcm4oJDEsbWlsdGVyX2RhdGFfdHlw
ZSxtaWx0ZXJfZGF0YV90eXBlKQorJykKKwpJbmRleDogcmVmcG9saWN5L3BvbGljeS9tb2R1
bGVzL3NlcnZpY2VzL3NwYW1hc3Nhc3Npbi5mYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSByZWZwb2xp
Y3kvcG9saWN5L21vZHVsZXMvc2VydmljZXMvc3BhbWFzc2Fzc2luLmZjCShyZXZpc2lvbiAy
ODAwKQorKysgcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3NwYW1hc3Nhc3Np
bi5mYwkod29ya2luZyBjb3B5KQpAQCAtMTAsNyArMTAsNiBAQAogL3Zhci9saWIvc3BhbWFz
c2Fzc2luKC8uKik/CWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOnNwYW1kX3Zhcl9s
aWJfdCxzMCkKIAogL3Zhci9ydW4vc3BhbWFzc2Fzc2luKC8uKik/CWdlbl9jb250ZXh0KHN5
c3RlbV91Om9iamVjdF9yOnNwYW1kX3Zhcl9ydW5fdCxzMCkKLS92YXIvcnVuL3NwYW1hc3Mt
bWlsdGVyKC8uKik/CWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOnNwYW1kX3Zhcl9y
dW5fdCxzMCkKIAogL3Zhci9zcG9vbC9zcGFtYXNzYXNzaW4oLy4qKT8JZ2VuX2NvbnRleHQo
c3lzdGVtX3U6b2JqZWN0X3I6c3BhbWRfc3Bvb2xfdCxzMCkKIC92YXIvc3Bvb2wvc3BhbWQo
Ly4qKT8JCWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOnNwYW1kX3Nwb29sX3QsczAp
CkluZGV4OiByZWZwb2xpY3kvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGZpeC50ZQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSByZWZwb2xpY3kvcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9z
dGZpeC50ZQkocmV2aXNpb24gMjgwMCkKKysrIHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9z
ZXJ2aWNlcy9wb3N0Zml4LnRlCSh3b3JraW5nIGNvcHkpCkBAIC01MzAsNiArNTMwLDEwIEBA
CiAJY3lydXNfc3RyZWFtX2Nvbm5lY3QocG9zdGZpeF9zbXRwX3QpCiAnKQogCitvcHRpb25h
bF9wb2xpY3koYAorCW1pbHRlcl9zdHJlYW1fY29ubmVjdF9hbGwocG9zdGZpeF9zbXRwX3Qp
CisnKQorCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiAjCiAj
IFBvc3RmaXggc210cGQgbG9jYWwgcG9saWN5Cg==
--------------050805090009030300020309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
