Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1L3lb3p024840
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 22:47:37 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1L3msFm008253
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 03:48:54 GMT
Received: by wr-out-0506.google.com with SMTP id i7so2725939wra
        for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 19:48:54 -0800 (PST)
Message-ID: <e739902b0702201948k5d7d998enc2f2ca1c794a4d68@mail.gmail.com>
Date: Tue, 20 Feb 2007 19:48:53 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: apache.fc references undefined user_cron_spool_t when using the strict policy.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1172004617.20576.241.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_83872_12704355.1172029733442"
References: <e739902b0702181646u72b958cei7ada50920711f9ea@mail.gmail.com>
	 <1172004617.20576.241.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_83872_12704355.1172029733442
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Chris,

I have updated my patch to remove the entry from the apache.fc file.

Thanks!

- Ryan


On 2/20/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> Its a bug, that line should have been in cron.fc.  I question if that
> was the right way to label that file anyway.  So it might be better to
> remove it altogether.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150

------=_Part_83872_12704355.1172029733442
Content-Type: text/x-patch; name=apache.fc.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyf87w58
Content-Disposition: attachment; filename="apache.fc.patch"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL2FwYWNoZS5mYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBw
b2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9hcGFjaGUuZmMJKHJldmlzaW9uIDIxODIpCisrKyBwb2xp
Y3kvbW9kdWxlcy9zZXJ2aWNlcy9hcGFjaGUuZmMJKHdvcmtpbmcgY29weSkKQEAgLTczLDkgKzcz
LDYgQEAKIAogL3Zhci9zcG9vbC9nb3NhKC8uKik/CQkJZ2VuX2NvbnRleHQoc3lzdGVtX3U6b2Jq
ZWN0X3I6aHR0cGRfc3lzX3NjcmlwdF9yd190LHMwKQogL3Zhci9zcG9vbC9zcXVpcnJlbG1haWwo
Ly4qKT8JCWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOnNxdWlycmVsbWFpbF9zcG9vbF90
LHMwKQotaWZkZWYoYHN0cmljdF9wb2xpY3knLGAKLS92YXIvc3Bvb2wvY3Jvbi9hcGFjaGUJCS0t
IAlnZW5fY29udGV4dChzeXN0ZW1fdTpvYmplY3Rfcjp1c2VyX2Nyb25fc3Bvb2xfdCxzMCkKLScp
CiAKIC92YXIvd3d3KC8uKik/CQkJCWdlbl9jb250ZXh0KHN5c3RlbV91Om9iamVjdF9yOmh0dHBk
X3N5c19jb250ZW50X3QsczApCiAvdmFyL3d3dy9jZ2ktYmluKC8uKik/CQkJZ2VuX2NvbnRleHQo
c3lzdGVtX3U6b2JqZWN0X3I6aHR0cGRfc3lzX3NjcmlwdF9leGVjX3QsczApCg==
------=_Part_83872_12704355.1172029733442--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
