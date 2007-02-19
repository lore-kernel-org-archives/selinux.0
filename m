Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1J0jO2p028766
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 19:45:24 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1J0keBV011940
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 00:46:40 GMT
Received: by nz-out-0506.google.com with SMTP id z3so1427193nzf
        for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 16:46:38 -0800 (PST)
Message-ID: <e739902b0702181646u72b958cei7ada50920711f9ea@mail.gmail.com>
Date: Sun, 18 Feb 2007 16:46:35 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: apache.fc references undefined user_cron_spool_t when using the strict policy.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_34670_19641424.1171845995172"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_34670_19641424.1171845995172
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

The apache module does not compile in the in the strict policy because
it references the following type: user_cron_spool_t which does not
appear to exist any longer.   Since I am not using apache, I just
commented out the block .. but thought I should pass this information
on in case someone else has a better fix.

I have attached a patch with the commented out block for reference.

Thanks,

- Ryan

------=_Part_34670_19641424.1171845995172
Content-Type: text/x-patch; name=apache.fc.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyc6txqn
Content-Disposition: attachment; filename="apache.fc.patch"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL2FwYWNoZS5mYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBw
b2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9hcGFjaGUuZmMJKHJldmlzaW9uIDIxODEpCisrKyBwb2xp
Y3kvbW9kdWxlcy9zZXJ2aWNlcy9hcGFjaGUuZmMJKHdvcmtpbmcgY29weSkKQEAgLTczLDEwICs3
MywxMiBAQAogCiAvdmFyL3Nwb29sL2dvc2EoLy4qKT8JCQlnZW5fY29udGV4dChzeXN0ZW1fdTpv
YmplY3RfcjpodHRwZF9zeXNfc2NyaXB0X3J3X3QsczApCiAvdmFyL3Nwb29sL3NxdWlycmVsbWFp
bCgvLiopPwkJZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2JqZWN0X3I6c3F1aXJyZWxtYWlsX3Nwb29s
X3QsczApCi1pZmRlZihgc3RyaWN0X3BvbGljeScsYAotL3Zhci9zcG9vbC9jcm9uL2FwYWNoZQkJ
LS0gCWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOnVzZXJfY3Jvbl9zcG9vbF90LHMwKQot
JykKIAorIyB1c2VyX2Nyb25fc3Bvb2xfdCBkb2VzIG5vdCBhcHBlYXIgdG8gZXhpc3QgYW55IGxv
bmdlci4KKyNpZmRlZihgc3RyaWN0X3BvbGljeScsYAorIy92YXIvc3Bvb2wvY3Jvbi9hcGFjaGUJ
CS0tIAlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3Rfcjp1c2VyX2Nyb25fc3Bvb2xfdCxzMCkK
KyMnKQorCiAvdmFyL3d3dygvLiopPwkJCQlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3Rfcjpo
dHRwZF9zeXNfY29udGVudF90LHMwKQogL3Zhci93d3cvY2dpLWJpbigvLiopPwkJCWdlbl9jb250
ZXh0KHN5c3RlbV91Om9iamVjdF9yOmh0dHBkX3N5c19zY3JpcHRfZXhlY190LHMwKQogL3Zhci93
d3cvaWNvbnMoLy4qKT8JCQlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3RfcjpodHRwZF9zeXNf
Y29udGVudF90LHMwKQo=
------=_Part_34670_19641424.1171845995172--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
