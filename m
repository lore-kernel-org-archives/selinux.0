Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86CbsJt018302
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 08:37:54 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l86CbqHo006002
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 12:37:53 GMT
Message-ID: <46DFF49C.8040905@redhat.com>
Date: Thu, 06 Sep 2007 08:37:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Athey <jathey@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: fix rpm_execcon in SWIG bindings
References: <1181744873.18728.10.camel@exodus.columbia.tresys.com>	 <46DD6A6C.2040305@redhat.com> <1189020922.8528.10.camel@exodus.columbia.tresys.com>
In-Reply-To: <1189020922.8528.10.camel@exodus.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Athey wrote:
> On Tue, 2007-09-04 at 10:23 -0400, Daniel J Walsh wrote:
>> https://bugzilla.redhat.com/show_bug.cgi?id=276121
>>
>> Bug in refactored SWIG Bindings.
>>
>>
>> #!/usr/bin/python
>>
>> import selinux
>> args = [ "/bin/bash", "--version" ]
>> selinux.rpm_execcon(0, args[0], args, [ ])
>>
>> Produces:
>>
>> Traceback (most recent call last):
>>   File "test.py", line 5, in <module>
>>     selinux.rpm_execcon(0, args[0], args, [ ])
>> TypeError: in method 'rpm_execcon', argument 3 of type 'char *const []'
>>
>> Version-Release number of selected component (if applicable):
>> libselinux-2.0.31-3.fc8
>>
>> James do  you have a nice quick fix for this?
> 
> It's nice, it's quick, and I think it's a fix, but I'll let you be the
> judge of that.
> 
> 
Works for me.

Updated in rawhide.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG3/ScrlYvE4MpobMRAqDWAKCb82kdVoqccXUk1KDyGw17kzyRBACghIlB
V4pH947JvzdUUxeKITc+qUU=
=+ZBw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
