Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p26IUGUD022816
	for <selinux@tycho.nsa.gov>; Sun, 6 Mar 2011 13:30:18 -0500
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p26IUG2V024452
	for <selinux@tycho.nsa.gov>; Sun, 6 Mar 2011 18:30:17 GMT
Received: by ewy7 with SMTP id 7so1125333ewy.12
        for <selinux@tycho.nsa.gov>; Sun, 06 Mar 2011 10:30:16 -0800 (PST)
Message-ID: <4D73D2B4.8070401@gmail.com>
Date: Sun, 06 Mar 2011 19:30:12 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sbrandmair@gmx.net
Subject: Re: [SELinux] Wildcard for object classes?
References: <ii11vf$vns$02$1@news.t-online.com> <201103061032.21143.russell@coker.com.au>
In-Reply-To: <201103061032.21143.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/06/2011 12:32 AM, Russell Coker wrote:
> On Sat, 29 Jan 2011, Simon Brandmair <sbrandmair@gmx.net> wrote:
>> I just started looking into SELinux. I am wondering if there is a way to
>> have wildcards in avc rules like:
>> auditallow source_t target_t : * * ;
>> which audits all access from source_t to target_t.
>>
>> Or do I have to add all classes objects to the rule like:
>> auditallow source_t target_t : {appletalk_socket, association,
>> blk_file ... } * ;
> 
> No, there isn't such a wildcard at this time (AFAIK).  It might be worth 
> adding one so I've moved this discussion to the SE Linux upstream mailing list 
> (please don't CC debian-security on future replies).
> 

Not possible and as far as i know neither is your second suggestion.
This is because not all permissions can be used with all object classes.

You would add a rule for each object class type (or set of object
classes that share the same permissions):

auditallow source target:notdevfile_class_set *;
auditallow source target:devfile_class_set *;
auditallow source target:socket_class_set *;
auditallow source target:file_class_set *;

etc, etc.

I am not sure if auditallow is the right way to do this. Maybe the audit
suite has better options for your requirements.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1z0rMACgkQMlxVo39jgT/t6gCg1T3AquC6RVeUpY2KEnQMdZT1
AowAoJgPYENYYXvTmRJVhtqSXpxKwFbv
=zUKb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
