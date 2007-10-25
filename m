Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9PFAksC029189
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 11:10:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9PFAjvA016572
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 15:10:45 GMT
Message-ID: <4720B1F2.9040000@redhat.com>
Date: Thu, 25 Oct 2007 11:10:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: HOME_DIR in .fc works?
References: <471F6C7D.7090807@gmail.com>	 <cadfc0e40710241143n2b26c909m52e3ca1756ffde1b@mail.gmail.com> <cadfc0e40710250806o514cab07w264f641e53d2b102@mail.gmail.com>
In-Reply-To: <cadfc0e40710250806o514cab07w264f641e53d2b102@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Toth wrote:
> On RHEL5 genhomedircon is not processing my fc entries because they
> are specifying "<<none>>" for the context. In the getHomeDirContext
> function there is a call to security_check_context which fails for
> "<<none>>" so the substituted string is not appended to the output.
> Maybe this check should be something like:
> if selinux.security_check_context(scon) == 0 or scon == "<<none>>":
> 
> 
> On 10/24/07, Xavier Toth <txtoth@gmail.com> wrote:
>> I'm getting the impression that genhomedircon is involved with the
>> solution to my problem. Maybe you can't use HOME_DIR in a policy
>> module? If I can then maybe I need to run genhomedircon to get
>> homedir_templates processed into file_contexts.homedirs?
>>
>> On 10/24/07, Ted X Toth <txtoth@gmail.com> wrote:
>>> I put entries into an .fc file to not relabel polyinstantied instance
>>> directories but they get relabeled, am I doing it right:
>>> HOME_DIR/\.mlrc\.inst/.*   <<none>>
>>>
>>> I don't see anything about this directory when I do:
>>> /usr/sbin/semanage fcontext -l | grep mlrc
>>>
>>> I do see them in /etc/selinux/mls/contexts/files/homedir_templates.
>>>
Seems reasonable.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHILHxrlYvE4MpobMRArgPAJ9lFBhv9VHRroSQ6OzrnFZAqOqCRQCguy1z
LP3oCDbEqvZlF7G5iXCA79g=
=VUfA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
