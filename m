Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75A4iG3031571
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 06:04:47 -0400
Received: from goalkeeper.city-fan.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75A4bHq016512
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:04:38 GMT
Message-ID: <48982587.30605@city-fan.org>
Date: Tue, 05 Aug 2008 11:03:51 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Milter Mail Filters
References: <484D4B53.5020006@city-fan.org> <1216385922.21191.125.camel@gorn>
In-Reply-To: <1216385922.21191.125.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------030602050208040003010803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030602050208040003010803
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Mon, 2008-06-09 at 16:25 +0100, Paul Howarth wrote:
>> Hi,
>>
>> attached is a patch based on local policy I'm using on Fedora 9 to 
>> support two "milter" mail filter daemons in conjunction with
>> sendmail, 
>> namely spamass-milter and milter-regex (I maintain the packages for
>> both 
>> of these in Fedora).
>>
>> I've taken the view that most milter applications will have similar 
>> requirements and so I've created a milter_template interface that 
>> contains most of what's needed, and then added the specifics that are 
>> needed on top of the generic stuff for each application.
>>
>> However, as I'm by no means an selinux expert, there are a number of 
>> things I'm unsure about:
>>
>> 1. In a situation where sendmail is the running MTA on a system, what
>> is 
>> the difference between sendmail_t and system_mail_t?
>>
>> 2. MTAs other than sendmail (postfix comes to mind) can also use 
>> milters, but as I don't have any boxes running postfix, I don't know 
>> what I'd need to add to postfix policy to support milters.
>>
>> 3. Fedora 9 has an interface spamassassin_domtrans_spamc that I used
>> in 
>> my local policy. It doesn't appear to be present in refpolicy; what 
>> would be the right thing to use for a daemon calling spamc?
>>
>> 4. I cribbed the milter_port_t stuff from the only example I could
>> find, 
>> and it's probably wrong. What would be the correct way of defining
>> this?
>>
>> 5. Does the use of a template for these applications a sane way to do
>> it?
>>
>> Paul.
>>
>>
>>
>>
>>
>>
>>
>> plain text
>> document
>> attachment
>> (milters.patch)
>>
>> Index: policy/modules/services/milters.te
>> ===================================================================
>> --- policy/modules/services/milters.te  (revision 0)
>> +++ policy/modules/services/milters.te  (revision 0)
>> @@ -0,0 +1,44 @@
>> +policy_module(milters,0.0.7)
>> +
>> +require {
>> +       attribute port_type;
>> +}
>> +
>> +type milter_port_t, port_type;
> 
> This declaration would move to corenetwork

Moved.

>> +#============= milter-regex policy ==============
>> +milter_template(regex)
> 
> As I mentioned before, it doesn't look like a template is needed, unless
> you think there will be many more milter domains.  Then put all the
> declarations in a section.

There are plenty of milters out there - see http://www.milter.org/milters

Not sure what you mean by "put all the declarations in a section". The 
current version has very few declarations anyway now.

>> +# Config is in /etc/mail/milter-regex.conf
>> +mta_read_config(milter_regex_t)
>> +
>> +# The milter creates a socket in /var/spool/milter-regex/
>> +# for communication with sendmail
>> +files_search_spool(milter_regex_t)
>> +manage_sock_files_pattern(milter_regex_t,milter_regex_spool_t,milter_regex_spool_t)
> 
> If the /var/sool/milter-regex directory can be created by the milter,
> then there should be a files_spool_filetrans().  If you think templates
> are warranted, then it would seem that this should go into the template

That directory would be part of the package for the milter and wouldn't 
need to be created at runtime (it needs specific DAC 
permissions/ownership anyway).

>> +# It removes any existing socket (not owned by root) whilst running
>> as root
>> +# and then calls setgid() and setuid() to drop privileges
>> +allow milter_regex_t self:capability { setuid setgid dac_override };
>> +
>> +
>> +#============= spamass-milter policy ==============
>> +milter_template(spamass)
>> +
>> +# The milter creates a socket in /var/run/spamass-milter/
>> +# for communication with sendmail
>> +manage_files_pattern(milter_spamass_t,milter_spamass_var_run_t,milter_spamass_var_run_t)
>> +manage_sock_files_pattern(milter_spamass_t,milter_spamass_var_run_t,milter_spamass_var_run_t)
>> +
>> +# The main job of the milter is to pipe spam through spamc and act on
>> the result
>> +#
>> +# The spamassassin_domtrans_spamc interface in Fedora 9 ???
>> +#spamassassin_domtrans_spamc(milter_spamass_t)

This interface is part of the big patch merge from Fedora. I could split 
out the part needed by spamass-milter as a separate patch if that's helpful.

>> +# When used with -b or -B options, the milter invokes sendmail to
>> send mail
>> +# to a spamtrap address, using popen()
>> +corecmd_exec_shell(milter_spamass_t)
>> +corecmd_read_bin_symlinks(milter_spamass_t)
>> +corecmd_search_bin(milter_spamass_t)
>> +kernel_read_system_state(milter_spamass_t)
>> +mta_send_mail(milter_spamass_t)
> 
> Similar comments as the previous domain.
> 
>> --- policy/modules/services/sendmail.te (revision 2710)
>> +++ policy/modules/services/sendmail.te (working copy)
>> @@ -112,6 +112,14 @@
>>  ')
>>  
>>  optional_policy(`
>> +       milter_regex_stream_connect(sendmail_t)
>> +')
>> +
>> +optional_policy(`
>> +       milter_spamass_stream_connect(sendmail_t)
>> +')
> 
> Perhaps this should be a single milter_stream_connect_all(), since it
> seems like sendmail would want to connect to all milters.

Indeed it does, and postfix too. I'm using typeattributes to achieve 
this now.

>> --- policy/modules/services/milters.fc  (revision 0)
>> +++ policy/modules/services/milters.fc  (revision 0)
>> @@ -0,0 +1,14 @@
>> +#================= contexts for milter-regex =================
>> +
>> +/usr/sbin/milter-regex         --      gen_context(system_u:object_r:milter_regex_exec_t,s0)
>> +
>> +/var/spool/milter-regex(/.*)?          gen_context(system_u:object_r:milter_regex_spool_t,s0)
>> +
>> +#================= contexts for spamass-milter =================
>> +
>> +/usr/sbin/spamass-milter       --      gen_context(system_u:object_r:milter_spamass_exec_t,s0)
>> +
>> +/var/run/spamass-milter
>> \.pid   --      gen_context(system_u:object_r:milter_spamass_var_run_t,s0)
>> +/var/run/spamass-milter(/.*)?          gen_context(system_u:object_r:milter_spamass_var_run_t,s0)
> 
> The comments don't really add anything here IMO.

OK, removed.

>> +template(`milter_template',`
> [...]
>> +       # This type is for pidfiles etc.
>> +       type milter_$1_var_run_t;
>> +       files_type(milter_$1_var_run_t);
>> +
>> +       # This type is for spool/cache data etc.
>> +       type milter_$1_cache_t;
>> +       files_type(milter_$1_cache_t);
>> +
>> +       # This type is for spool/cache data etc.
>> +       type milter_$1_spool_t;
>> +       files_type(milter_$1_spool_t);
>> +
>> +       # This type is for state data etc.
>> +       type milter_$1_var_lib_t;
>> +       files_type(milter_$1_var_lib_t);
> 
> Most of these types aren't used, so they should be dropped.

I've merged most of the types together now.

>> +interface(`milter_spamass_stream_connect',`
>> +       gen_require(`
>> +               type milter_spamass_var_run_t, milter_spamass_t;
>> +       ')
>> +       stream_connect_pattern($1,milter_spamass_var_run_t,milter_spamass_var_run_t,milter_spamass_t)
>> +')
>> +
> 
> Missing a files_search_spool().  Interface name needs to be fixed [1].

I have two interfaces now, common to all milters:

milter_stream_connect
milter_getattr_socket_dir

I'll try claiming that "milter" is an abbreviation of "milters"; any 
suggestions for better predicate names?

>> +interface(`milter_spamass_rw_stream_sockets',`
>> +        gen_require(`
>> +                type milter_spamass_t;
>> +        ')
>> +
>> +       allow $1 milter_spamass_t:unix_stream_socket { read write };
>> +')
> 
> Interface naming fix.
> 
> 
>> +interface(`milter_regex_stream_connect',`
>> +       gen_require(`
>> +               type milter_regex_spool_t, milter_regex_t;
>> +       ')
>> +       stream_connect_pattern($1,milter_regex_spool_t,milter_regex_spool_t,milter_regex_t)
>> +')
> 
> Also missing a files_search_spool() and interface naming fix.

I'm now using milter_$1_data_dir_t in the interface, where this 
directory might live under /var/spool for some milters, /var/run for 
others etc. So I added files_search_spool() in the te file for the 
milter(s) that needed it (only).

Heavily revised patch attached. The individual milter policies are quite 
brief now (and there are plenty more that could be added), which I think 
justifies the template approach. No further changes should need to be 
made to the sendmail and postfix policies to support additional milters 
either.

Paul.

--------------030602050208040003010803
Content-Type: text/plain;
 name="milters.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="milters.patch"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9jb3JlbmV0d29yay50ZS5pbgo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBwb2xpY3kvbW9kdWxlcy9rZXJuZWwvY29yZW5ldHdvcmsudGUuaW4JKHJl
dmlzaW9uIDI3NzApCisrKyBwb2xpY3kvbW9kdWxlcy9rZXJuZWwvY29yZW5ldHdvcmsudGUu
aW4JKHdvcmtpbmcgY29weSkKQEAgLTExOSw2ICsxMTksNyBAQAogdHlwZSBscnJkX3BvcnRf
dCwgcG9ydF90eXBlOyBkbmwgbmV0d29ya19wb3J0KGxycmRfcG9ydF90KSAjIG5vIGRlZmlu
ZWQgcG9ydGNvbgogbmV0d29ya19wb3J0KGxtdHAsIHRjcCwyNCxzMCwgdWRwLDI0LHMwKQog
bmV0d29ya19wb3J0KG1haWwsIHRjcCwyMDAwLHMwKQordHlwZSBtaWx0ZXJfcG9ydF90LCBw
b3J0X3R5cGU7IGRubCBuZXR3b3JrX3BvcnQobWlsdGVyKSAjIG5vIGRlZmluZWQgcG9ydGNv
bgogbmV0d29ya19wb3J0KG1tY2MsIHRjcCw1MDUwLHMwLCB1ZHAsNTA1MCxzMCkKIG5ldHdv
cmtfcG9ydChtb25vcGQsIHRjcCwxMjM0LHMwKQogbmV0d29ya19wb3J0KG1zbnAsIHRjcCwx
ODYzLHMwLCB1ZHAsMTg2MyxzMCkKSW5kZXg6IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL21p
bHRlcnMudGUKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQotLS0gcG9saWN5L21vZHVsZXMvc2VydmljZXMvbWls
dGVycy50ZQkocmV2aXNpb24gMCkKKysrIHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL21pbHRl
cnMudGUJKHJldmlzaW9uIDApCkBAIC0wLDAgKzEsNDIgQEAKK3BvbGljeV9tb2R1bGUobWls
dGVycywwLjEuNCkKKworcmVxdWlyZSB7CisJYXR0cmlidXRlIHBvcnRfdHlwZTsKK30KKwor
Iz09PT09PT09PT09PT0gZGVjbGFyYXRpb25zID09PT09PT09PT09PT09PT0KKworIyBhdHRy
aWJ1dGVzIGNvbW1vbiB0byBhbGwgbWlsdGVycworYXR0cmlidXRlIG1pbHRlcl9kb21haW5z
OworYXR0cmlidXRlIG1pbHRlcl9zb2NrZXRfZGlyZWN0b3JpZXM7CithdHRyaWJ1dGUgbWls
dGVyX3NvY2tldF90eXBlOworCisKKyM9PT09PT09PT09PT09IG1pbHRlci1yZWdleCBwb2xp
Y3kgPT09PT09PT09PT09PT0KK21pbHRlcl90ZW1wbGF0ZShyZWdleCkKKworIyBDb25maWcg
aXMgaW4gL2V0Yy9tYWlsL21pbHRlci1yZWdleC5jb25mCittdGFfcmVhZF9jb25maWcobWls
dGVyX3JlZ2V4X3QpCisKKyMgVGhlIG1pbHRlcidzIHNvY2tldCBkaXJlY3RvcnkgbGl2ZXMg
dW5kZXIgL3Zhci9zcG9vbAorZmlsZXNfc2VhcmNoX3Nwb29sKG1pbHRlcl9yZWdleF90KQor
CisjIEl0IHJlbW92ZXMgYW55IGV4aXN0aW5nIHNvY2tldCAobm90IG93bmVkIGJ5IHJvb3Qp
IHdoaWxzdCBydW5uaW5nIGFzIHJvb3QKKyMgYW5kIHRoZW4gY2FsbHMgc2V0Z2lkKCkgYW5k
IHNldHVpZCgpIHRvIGRyb3AgcHJpdmlsZWdlcworYWxsb3cgbWlsdGVyX3JlZ2V4X3Qgc2Vs
ZjpjYXBhYmlsaXR5IHsgc2V0dWlkIHNldGdpZCBkYWNfb3ZlcnJpZGUgfTsKKworCisjPT09
PT09PT09PT09PSBzcGFtYXNzLW1pbHRlciBwb2xpY3kgPT09PT09PT09PT09PT0KK21pbHRl
cl90ZW1wbGF0ZShzcGFtYXNzKQorCisjIFRoZSBtYWluIGpvYiBvZiB0aGUgbWlsdGVyIGlz
IHRvIHBpcGUgc3BhbSB0aHJvdWdoIHNwYW1jIGFuZCBhY3Qgb24gdGhlIHJlc3VsdAorc3Bh
bWFzc2Fzc2luX2RvbXRyYW5zX3NwYW1jKG1pbHRlcl9zcGFtYXNzX3QpCisKKyMgV2hlbiB1
c2VkIHdpdGggLWIgb3IgLUIgb3B0aW9ucywgdGhlIG1pbHRlciBpbnZva2VzIHNlbmRtYWls
IHRvIHNlbmQgbWFpbAorIyB0byBhIHNwYW10cmFwIGFkZHJlc3MsIHVzaW5nIHBvcGVuKCkK
K2NvcmVjbWRfZXhlY19zaGVsbChtaWx0ZXJfc3BhbWFzc190KQorY29yZWNtZF9yZWFkX2Jp
bl9zeW1saW5rcyhtaWx0ZXJfc3BhbWFzc190KQorY29yZWNtZF9zZWFyY2hfYmluKG1pbHRl
cl9zcGFtYXNzX3QpCitrZXJuZWxfcmVhZF9zeXN0ZW1fc3RhdGUobWlsdGVyX3NwYW1hc3Nf
dCkKK210YV9zZW5kX21haWwobWlsdGVyX3NwYW1hc3NfdCkKKwpJbmRleDogcG9saWN5L21v
ZHVsZXMvc2VydmljZXMvc2VuZG1haWwudGUKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gcG9saWN5L21v
ZHVsZXMvc2VydmljZXMvc2VuZG1haWwudGUJKHJldmlzaW9uIDI3NzApCisrKyBwb2xpY3kv
bW9kdWxlcy9zZXJ2aWNlcy9zZW5kbWFpbC50ZQkod29ya2luZyBjb3B5KQpAQCAtMTEyLDYg
KzExMiwxMCBAQAogJykKIAogb3B0aW9uYWxfcG9saWN5KGAKKwltaWx0ZXJfc3RyZWFtX2Nv
bm5lY3Qoc2VuZG1haWxfdCkKKycpCisKK29wdGlvbmFsX3BvbGljeShgCiAJcG9zdGZpeF9l
eGVjX21hc3RlcihzZW5kbWFpbF90KQogCXBvc3RmaXhfcmVhZF9jb25maWcoc2VuZG1haWxf
dCkKIAlwb3N0Zml4X3NlYXJjaF9zcG9vbChzZW5kbWFpbF90KQpJbmRleDogcG9saWN5L21v
ZHVsZXMvc2VydmljZXMvbWlsdGVycy5mYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBwb2xpY3kvbW9k
dWxlcy9zZXJ2aWNlcy9taWx0ZXJzLmZjCShyZXZpc2lvbiAwKQorKysgcG9saWN5L21vZHVs
ZXMvc2VydmljZXMvbWlsdGVycy5mYwkocmV2aXNpb24gMCkKQEAgLTAsMCArMSwxMyBAQAor
L3Vzci9zYmluL21pbHRlci1yZWdleAkJCQktLQlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmpl
Y3RfcjptaWx0ZXJfcmVnZXhfZXhlY190LHMwKQorL3Zhci9zcG9vbC9taWx0ZXItcmVnZXgJ
CQkJLWQJZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6bWlsdGVyX3JlZ2V4X2RhdGFf
ZGlyX3QsczApCisvdmFyL3Nwb29sL21pbHRlci1yZWdleC9zb2NrCQkJLXMJZ2VuX2NvbnRl
eHQoc3lzdGVtX3U6b2JqZWN0X3I6bWlsdGVyX3JlZ2V4X3NvY2tldF90LHMwKQorL3Zhci9z
cG9vbC9taWx0ZXItcmVnZXgvLisJCQkJZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6
bWlsdGVyX3JlZ2V4X2RhdGFfdCxzMCkKKworL3Vzci9zYmluL3NwYW1hc3MtbWlsdGVyCQkJ
LS0JZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6bWlsdGVyX3NwYW1hc3NfZXhlY190
LHMwKQorL3Zhci9ydW4vc3BhbWFzcy1taWx0ZXIJCQkJLWQJZ2VuX2NvbnRleHQoc3lzdGVt
X3U6b2JqZWN0X3I6bWlsdGVyX3NwYW1hc3NfZGF0YV9kaXJfdCxzMCkKKy92YXIvcnVuL3Nw
YW1hc3MtbWlsdGVyXC5waWQJCQktLQlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3Rfcjpt
aWx0ZXJfc3BhbWFzc19kYXRhX3QsczApCisvdmFyL3J1bi9zcGFtYXNzLW1pbHRlci9zcGFt
YXNzLW1pbHRlclwuc29jawktcwlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3RfcjptaWx0
ZXJfc3BhbWFzc19zb2NrZXRfdCxzMCkKKy92YXIvcnVuL3NwYW1hc3MtbWlsdGVyLy4rCQkJ
CWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOm1pbHRlcl9zcGFtYXNzX2RhdGFfdCxz
MCkKKy92YXIvcnVuL3NwYW1hc3MtbWlsdGVyL3Bvc3RmaXgJCQktZAlnZW5fY29udGV4dChz
eXN0ZW1fdTpvYmplY3RfcjptaWx0ZXJfc3BhbWFzc19kYXRhX2Rpcl90LHMwKQorL3Zhci9y
dW4vc3BhbWFzcy1taWx0ZXIvcG9zdGZpeC9zb2NrCQktcwlnZW5fY29udGV4dChzeXN0ZW1f
dTpvYmplY3RfcjptaWx0ZXJfc3BhbWFzc19zb2NrZXRfdCxzMCkKKwpJbmRleDogcG9saWN5
L21vZHVsZXMvc2VydmljZXMvbXRhLnRlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHBvbGljeS9tb2R1
bGVzL3NlcnZpY2VzL210YS50ZQkocmV2aXNpb24gMjc3MCkKKysrIHBvbGljeS9tb2R1bGVz
L3NlcnZpY2VzL210YS50ZQkod29ya2luZyBjb3B5KQpAQCAtMTA1LDYgKzEwNSw5IEBACiAJ
IyBwb3N0Zml4IG5lZWRzIHRoaXMgZm9yIG5ld2FsaWFzZXMKIAlmaWxlc19nZXRhdHRyX3Rt
cF9kaXJzKHN5c3RlbV9tYWlsX3QpCiAKKwkjIG5ld2FsaWFzZXMgcnVucyBhcyBzeXN0ZW1f
bWFpbF90IHdoZW4gdGhlIHNlbmRtYWlsIGluaXRzY3JpcHQgZG9lcyBhIHJlc3RhcnQKKwlt
aWx0ZXJfZ2V0YXR0cl9zb2NrZXRfZGlyKHN5c3RlbV9tYWlsX3QpCisKIAlwb3N0Zml4X2V4
ZWNfbWFzdGVyKHN5c3RlbV9tYWlsX3QpCiAJcG9zdGZpeF9yZWFkX2NvbmZpZyhzeXN0ZW1f
bWFpbF90KQogCXBvc3RmaXhfc2VhcmNoX3Nwb29sKHN5c3RlbV9tYWlsX3QpCkluZGV4OiBw
b2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9taWx0ZXJzLmlmCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHBv
bGljeS9tb2R1bGVzL3NlcnZpY2VzL21pbHRlcnMuaWYJKHJldmlzaW9uIDApCisrKyBwb2xp
Y3kvbW9kdWxlcy9zZXJ2aWNlcy9taWx0ZXJzLmlmCShyZXZpc2lvbiAwKQpAQCAtMCwwICsx
LDEwOCBAQAorIyMgPHN1bW1hcnk+TWlsdGVyIG1haWwgZmlsdGVyczwvc3VtbWFyeT4KKwor
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIworIyMgPHN1bW1hcnk+
CisjIwlDcmVhdGUgYSBzZXQgb2YgZGVyaXZlZCB0eXBlcyBmb3IgdmFyaW91cworIyMJbWFp
bCBmaWx0ZXIgYXBwbGljYXRpb25zIHVzaW5nIHRoZSBtaWx0ZXIgaW50ZXJmYWNlLgorIyMg
PC9zdW1tYXJ5PgorIyMgPHBhcmFtIG5hbWU9Im1pbHRlcl9uYW1lIj4KKyMjCTxzdW1tYXJ5
PgorIyMJVGhlIG5hbWUgdG8gYmUgdXNlZCBmb3IgZGVyaXZpbmcgdHlwZSBuYW1lcy4KKyMj
CTwvc3VtbWFyeT4KKyMjIDwvcGFyYW0+CisjCit0ZW1wbGF0ZShgbWlsdGVyX3RlbXBsYXRl
JyxgCisKKwkjIGF0dHJpYnV0ZXMgY29tbW9uIHRvIGFsbCBtaWx0ZXJzLCBwbHVzIHBvcnQg
dHlwZSBmb3IgbWlsdGVyIFRDUCBzb2NrZXRzCisJZ2VuX3JlcXVpcmUoYAorCQlhdHRyaWJ1
dGUgbWlsdGVyX3NvY2tldF9kaXJlY3RvcmllcywgbWlsdGVyX3NvY2tldF90eXBlLCBtaWx0
ZXJfZG9tYWluczsKKwkJdHlwZSBtaWx0ZXJfcG9ydF90OworCScpCisKKwkjIFR5cGUgdGhh
dCB0aGUgbWlsdGVyIGFwcGxpY2F0aW9uIHJ1bnMgYXMKKwl0eXBlIG1pbHRlcl8kMV90LCBt
aWx0ZXJfZG9tYWluczsKKwlkb21haW5fdHlwZShtaWx0ZXJfJDFfdCkKKwlyb2xlIHN5c3Rl
bV9yIHR5cGVzIG1pbHRlcl8kMV90OworCisJIyBUeXBlIGZvciB0aGUgZXhlY3V0YWJsZSBm
aWxlCisJdHlwZSBtaWx0ZXJfJDFfZXhlY190OworCWluaXRfZGFlbW9uX2RvbWFpbihtaWx0
ZXJfJDFfdCwgbWlsdGVyXyQxX2V4ZWNfdCkKKworCSMgVHlwZSBmb3IgdGhlIGRpcmVjdG9y
eSB0aGF0IHRoZSB1bml4LWRvbWFpbiBzb2NrZXQgZm9yIE1UQQorCSMgY29tbXVuaWNhdGlv
biB3aWxsIGxpdmUgaW4KKwl0eXBlIG1pbHRlcl8kMV9kYXRhX2Rpcl90LCBtaWx0ZXJfc29j
a2V0X2RpcmVjdG9yaWVzOworCWZpbGVzX3R5cGUobWlsdGVyXyQxX2RhdGFfZGlyX3QpCisK
KwkjIFR5cGUgZm9yIHRoZSB1bml4LWRvbWFpbiBzb2NrZXQgZm9yIE1UQSBjb21tdW5pY2F0
aW9uCisJdHlwZSBtaWx0ZXJfJDFfc29ja2V0X3QsIG1pbHRlcl9zb2NrZXRfdHlwZTsKKwlm
aWxlc190eXBlKG1pbHRlcl8kMV9zb2NrZXRfdCk7CisJZmlsZXRyYW5zX3BhdHRlcm4obWls
dGVyXyQxX3QsbWlsdGVyXyQxX2RhdGFfZGlyX3QsbWlsdGVyXyQxX3NvY2tldF90LHNvY2tf
ZmlsZSkKKworCSMgQW55IG90aGVyIGRhdGEgdGhlIG1pbHRlciBwdXRzIGluIGEgbWlsdGVy
X2RhdGFfZGlyX3QgZGlyZWN0b3J5CisJdHlwZSBtaWx0ZXJfJDFfZGF0YV90OworCWZpbGVz
X3R5cGUobWlsdGVyXyQxX2RhdGFfdCk7CisJZmlsZXRyYW5zX3BhdHRlcm4obWlsdGVyXyQx
X3QsbWlsdGVyXyQxX2RhdGFfZGlyX3QsbWlsdGVyXyQxX2RhdGFfdCx7IGRpciBmaWxlIH0p
CisKKwkjIEdlbmVyaWMgcnVsZXMgZnJvbSBwb2xpY3lnZW50b29sCisJZmlsZXNfcmVhZF9l
dGNfZmlsZXMobWlsdGVyXyQxX3QpCisJbGlic191c2VfbGRfc28obWlsdGVyXyQxX3QpCisJ
bGlic191c2Vfc2hhcmVkX2xpYnMobWlsdGVyXyQxX3QpCisJbWlzY2ZpbGVzX3JlYWRfbG9j
YWxpemF0aW9uKG1pbHRlcl8kMV90KQorCXN5c25ldF9kbnNfbmFtZV9yZXNvbHZlKG1pbHRl
cl8kMV90KQorCWluaXRfdXNlX2ZkcyhtaWx0ZXJfJDFfdCkKKwlpbml0X3VzZV9zY3JpcHRf
cHR5cyhtaWx0ZXJfJDFfdCkKKwlkb21haW5fdXNlX2ludGVyYWN0aXZlX2ZkcyhtaWx0ZXJf
JDFfdCkKKworCSMgQWxsb3cgY29tbXVuaWNhdGlvbiB3aXRoIE1UQSBvdmVyIGEgVENQIHNv
Y2tldAorCWFsbG93IG1pbHRlcl8kMV90IG1pbHRlcl9wb3J0X3Q6dGNwX3NvY2tldCBuYW1l
X2JpbmQ7CisJY29yZW5ldF90Y3BfYmluZF9nZW5lcmljX25vZGUobWlsdGVyXyQxX3QpCisJ
YWxsb3cgbWlsdGVyXyQxX3Qgc2VsZjp0Y3Bfc29ja2V0IHsgbGlzdGVuIGFjY2VwdCB9Owor
CisJIyBBbGxvdyBjb21tdW5pY2F0aW9uIHdpdGggTVRBIG92ZXIgYSB1bml4LWRvbWFpbiBz
b2NrZXQKKwltYW5hZ2Vfc29ja19maWxlc19wYXR0ZXJuKG1pbHRlcl8kMV90LG1pbHRlcl8k
MV9kYXRhX2Rpcl90LG1pbHRlcl8kMV9zb2NrZXRfdCkKKworCSMgQ3JlYXRlIG90aGVyIGRh
dGEgZmlsZXMgYW5kIGRpcmVjdG9yaWVzIGluIHRoZSBzb2NrZXQgZGlyZWN0b3J5CisJbWFu
YWdlX2ZpbGVzX3BhdHRlcm4obWlsdGVyXyQxX3QsbWlsdGVyXyQxX2RhdGFfZGlyX3QsbWls
dGVyXyQxX2RhdGFfdCkKKwltYW5hZ2VfZmlsZXNfcGF0dGVybihtaWx0ZXJfJDFfdCxtaWx0
ZXJfJDFfZGF0YV90LG1pbHRlcl8kMV9kYXRhX3QpCisKKwkjIFRoaW5ncyB0aGF0IG1vc3Qg
bWlsdGVycyB3aWxsIG5lZWQgdG8gZG8KKwlhbGxvdyBtaWx0ZXJfJDFfdCBzZWxmOmZpZm9f
ZmlsZSByd19maWZvX2ZpbGVfcGVybXM7CisJbG9nZ2luZ19zZW5kX3N5c2xvZ19tc2cobWls
dGVyXyQxX3QpCisKKycpCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMKKyMjIDxzdW1tYXJ5PgorIyMJTVRBIGNvbW11bmljYXRpb24gd2l0aCBtaWx0ZXIg
c29ja2V0cworIyMgPC9zdW1tYXJ5PgorIyMgPHBhcmFtIG5hbWU9ImRvbWFpbiI+CisjIwk8
c3VtbWFyeT4KKyMjCURvbWFpbiBhbGxvd2VkIGFjY2Vzcy4KKyMjCTwvc3VtbWFyeT4KKyMj
IDwvcGFyYW0+CisjCitpbnRlcmZhY2UoYG1pbHRlcl9zdHJlYW1fY29ubmVjdCcsYAorCWdl
bl9yZXF1aXJlKGAKKwkJYXR0cmlidXRlIG1pbHRlcl9zb2NrZXRfZGlyZWN0b3JpZXMsIG1p
bHRlcl9zb2NrZXRfdHlwZSwgbWlsdGVyX2RvbWFpbnM7CisJJykKKwlnZXRhdHRyX2RpcnNf
cGF0dGVybigkMSxtaWx0ZXJfc29ja2V0X2RpcmVjdG9yaWVzLG1pbHRlcl9zb2NrZXRfZGly
ZWN0b3JpZXMpCisJc3RyZWFtX2Nvbm5lY3RfcGF0dGVybigkMSxtaWx0ZXJfc29ja2V0X2Rp
cmVjdG9yaWVzLG1pbHRlcl9zb2NrZXRfdHlwZSxtaWx0ZXJfZG9tYWlucykKKycpCisKKyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKKyMjIDxzdW1tYXJ5Pgor
IyMJQWxsb3cgc2VhcmNoIG9mIG1pbHRlciBzb2NrZXQgZGlyZWN0b3J5CisjIyA8L3N1bW1h
cnk+CisjIyA8cGFyYW0gbmFtZT0iZG9tYWluIj4KKyMjCTxzdW1tYXJ5PgorIyMJRG9tYWlu
IGFsbG93ZWQgYWNjZXNzLgorIyMJPC9zdW1tYXJ5PgorIyMgPC9wYXJhbT4KKyMKK2ludGVy
ZmFjZShgbWlsdGVyX2dldGF0dHJfc29ja2V0X2RpcicsYAorCWdlbl9yZXF1aXJlKGAKKwkJ
YXR0cmlidXRlIG1pbHRlcl9zb2NrZXRfZGlyZWN0b3JpZXM7CisJJykKKwlnZXRhdHRyX2Rp
cnNfcGF0dGVybigkMSxtaWx0ZXJfc29ja2V0X2RpcmVjdG9yaWVzLG1pbHRlcl9zb2NrZXRf
ZGlyZWN0b3JpZXMpCisnKQorCkluZGV4OiBwb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9zcGFt
YXNzYXNzaW4uZmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gcG9saWN5L21vZHVsZXMvc2VydmljZXMv
c3BhbWFzc2Fzc2luLmZjCShyZXZpc2lvbiAyNzcwKQorKysgcG9saWN5L21vZHVsZXMvc2Vy
dmljZXMvc3BhbWFzc2Fzc2luLmZjCSh3b3JraW5nIGNvcHkpCkBAIC0xMCw3ICsxMCw2IEBA
CiAvdmFyL2xpYi9zcGFtYXNzYXNzaW4oLy4qKT8JZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2Jq
ZWN0X3I6c3BhbWRfdmFyX2xpYl90LHMwKQogCiAvdmFyL3J1bi9zcGFtYXNzYXNzaW4oLy4q
KT8JZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6c3BhbWRfdmFyX3J1bl90LHMwKQot
L3Zhci9ydW4vc3BhbWFzcy1taWx0ZXIoLy4qKT8JZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2Jq
ZWN0X3I6c3BhbWRfdmFyX3J1bl90LHMwKQogCiAvdmFyL3Nwb29sL3NwYW1hc3Nhc3Npbigv
LiopPwlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3RfcjpzcGFtZF9zcG9vbF90LHMwKQog
L3Zhci9zcG9vbC9zcGFtZCgvLiopPwkJZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6
c3BhbWRfc3Bvb2xfdCxzMCkKSW5kZXg6IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3Rm
aXgudGUKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gcG9saWN5L21vZHVsZXMvc2VydmljZXMvcG9zdGZp
eC50ZQkocmV2aXNpb24gMjc3MCkKKysrIHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3Bvc3Rm
aXgudGUJKHdvcmtpbmcgY29weSkKQEAgLTUzMCw2ICs1MzAsMTAgQEAKIAljeXJ1c19zdHJl
YW1fY29ubmVjdChwb3N0Zml4X3NtdHBfdCkKICcpCiAKK29wdGlvbmFsX3BvbGljeShgCisJ
bWlsdGVyX3N0cmVhbV9jb25uZWN0KHBvc3RmaXhfc210cF90KQorJykKKwogIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwogIwogIyBQb3N0Zml4IHNtdHBkIGxv
Y2FsIHBvbGljeQo=
--------------030602050208040003010803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
