Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A56@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: RE: root login with enforcing on
Date: Mon, 27 Oct 2003 09:15:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks.  The file_type_auto_trans macro did the trick.

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Friday, October 24, 2003 4:33 PM
To: James R. Kratzer
Cc: SELinux (E-mail); Russell Coker; Howard Holm
Subject: Re: root login with enforcing on


In your case, you are likely looking for something like:
file_type_auto_trans(staff_t, sysadm_home_dir_t, sysadm_home_t)
to allow staff_t to fully access /root and make sure that any newly
created files in /root are placed into sysadm_home_t.
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
