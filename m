Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2F1hk2e010652
	for <selinux@tycho.nsa.gov>; Mon, 14 Mar 2011 21:43:47 -0400
Received: from countercultured.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p2F1hk0x011451
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2011 01:43:46 GMT
Message-ID: <4D7EC446.20102@davequigley.com>
Date: Mon, 14 Mar 2011 21:43:34 -0400
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov, sbrandmair@gmx.net
Subject: Re: [SELinux] Wildcard for object classes?
References: <ii11vf$vns$02$1@news.t-online.com> <201103061032.21143.russell@coker.com.au> <4D73D2B4.8070401@gmail.com>
In-Reply-To: <4D73D2B4.8070401@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/6/2011 1:30 PM, Dominick Grift wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 03/06/2011 12:32 AM, Russell Coker wrote:
>> On Sat, 29 Jan 2011, Simon Brandmair<sbrandmair@gmx.net>  wrote:
>>> I just started looking into SELinux. I am wondering if there is a way to
>>> have wildcards in avc rules like:
>>> auditallow source_t target_t : * * ;
>>> which audits all access from source_t to target_t.
>>>
>>> Or do I have to add all classes objects to the rule like:
>>> auditallow source_t target_t : {appletalk_socket, association,
>>> blk_file ... } * ;
>> No, there isn't such a wildcard at this time (AFAIK).  It might be worth
>> adding one so I've moved this discussion to the SE Linux upstream mailing list
>> (please don't CC debian-security on future replies).
>>
> Not possible and as far as i know neither is your second suggestion.
> This is because not all permissions can be used with all object classes.
>
> You would add a rule for each object class type (or set of object
> classes that share the same permissions):
>
> auditallow source target:notdevfile_class_set *;
> auditallow source target:devfile_class_set *;
> auditallow source target:socket_class_set *;
> auditallow source target:file_class_set *;
>
> etc, etc.
>
> I am not sure if auditallow is the right way to do this. Maybe the audit
> suite has better options for your requirements.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.16 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk1z0rMACgkQMlxVo39jgT/t6gCg1T3AquC6RVeUpY2KEnQMdZT1
> AowAoJgPYENYYXvTmRJVhtqSXpxKwFbv
> =zUKb
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
You could start with the policy made with mp (Make Dummy Policy) since 
that has rules for one type on all object classes to allow all 
permissions. Then from there you could turn that into an interface 
instead so it would expand to that entire rule set. The only downside is 
if a new object class is added you'll have to modify the new interface 
to include that one as well.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
