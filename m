Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1J0Wb7S028427
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 19:33:47 -0500
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1J0Xr5R013161
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 00:33:53 GMT
Received: by nz-out-0506.google.com with SMTP id z3so1425214nzf
        for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 16:33:43 -0800 (PST)
Message-ID: <e739902b0702181633md9e8fa9y55e74a5520cf7a60@mail.gmail.com>
Date: Sun, 18 Feb 2007 16:33:42 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Is the usercanread attribute still needed?
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_34570_10647493.1171845222292"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_34570_10647493.1171845222292
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I noticed the apache.te file used the file_types() macro instead of
the file_config_file() macro for the configuration files, so I looked
into the differences between the macros.

The files_config_file macro is listed below:

interface(`files_config_file',`
        gen_require(`
                attribute usercanread;
        ')

        files_type($1)

        # this is a hack and should be removed.
        typeattribute $1 usercanread;
')


After reading the comment above the typeattribute, I was curious to
figure out what the usercanread attribute was used for. Looking
through the SVN tree I found the following uses.

$ find . -type f | xargs grep  usercanread | grep -v '.svn'
./modules/kernel/files.if:              attribute usercanread;
./modules/kernel/files.if:      typeattribute $1 usercanread;
./modules/kernel/files.te:attribute usercanread;


I used the attached patched to remove the attribute from the files.te
and files.if file and the policy still compiled.  Is it safe to assume
we can remove the attribute now?  Or is the hack still needed for
something I am not seeing?

Thanks!

- Ryan

------=_Part_34570_10647493.1171845222292
Content-Type: text/x-patch; name=files.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyc6cim9
Content-Disposition: attachment; filename="files.patch"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlcy5pZgo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBwb2xp
Y3kvbW9kdWxlcy9rZXJuZWwvZmlsZXMuaWYJKHJldmlzaW9uIDIxODEpCisrKyBwb2xpY3kvbW9k
dWxlcy9rZXJuZWwvZmlsZXMuaWYJKHdvcmtpbmcgY29weSkKQEAgLTExMCwxNCArMTEwLDcgQEAK
ICMjIDwvcGFyYW0+CiAjCiBpbnRlcmZhY2UoYGZpbGVzX2NvbmZpZ19maWxlJyxgCi0JZ2VuX3Jl
cXVpcmUoYAotCQlhdHRyaWJ1dGUgdXNlcmNhbnJlYWQ7Ci0JJykKLQogCWZpbGVzX3R5cGUoJDEp
Ci0KLQkjIHRoaXMgaXMgYSBoYWNrIGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4KLQl0eXBlYXR0cmli
dXRlICQxIHVzZXJjYW5yZWFkOwogJykKIAogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpJbmRleDogcG9saWN5L21vZHVsZXMva2VybmVsL2ZpbGVzLnRlCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlcy50ZQkocmV2aXNpb24gMjE4MSkKKysr
IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlcy50ZQkod29ya2luZyBjb3B5KQpAQCAtMzAsOSAr
MzAsNiBAQAogYXR0cmlidXRlIHRtcGZpbGU7CiBhdHRyaWJ1dGUgdG1wZnNmaWxlOwogCi0jIHRo
aXMgaXMgYSBoYWNrIGFuZCBzaG91bGQgYmUgY2hhbmdlZAotYXR0cmlidXRlIHVzZXJjYW5yZWFk
OwotCiAjCiAjIGJvb3RfdCBpcyB0aGUgdHlwZSBmb3IgZmlsZXMgaW4gL2Jvb3QKICMK
------=_Part_34570_10647493.1171845222292--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
