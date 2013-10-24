Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OGerTn008004
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 12:40:53 -0400
Message-ID: <52694D8B.3050705@redhat.com>
Date: Thu, 24 Oct 2013 12:40:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Allow audit2allow to return constraint information from policy
References: <5269207C.4090809@redhat.com> <1382630560.3041.150.camel@d30>
In-Reply-To: <1382630560.3041.150.camel@d30>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/24/2013 12:02 PM, Dominick Grift wrote:
> On Thu, 2013-10-24 at 09:28 -0400, Daniel J Walsh wrote:
>> At the end of last year I was complaining about audit2allow and the
>> SELinux tools chain not being able to give better information about what
>> constraint is being violated, so a admin or policy writer could have a
>> clue on how to fix the problem.
>> 
>> A fairly common problem is domains trying to change the role or user
>> component of the label.  Or in the MCS and MLS world, what attribute do I
>> need to add to my policy to allow the AVC.
>> 
>> Richard Haines wrote some nice patches to add the constraint information
>> to the kernel and to change user space to reveal this information.
>> 
>> Sadly we thought these discussions had happened on the list, but I guess
>> we had taken it private.  Here is the userspace patch to reveal this
>> information.
>> 
>> The kernel team will be posting the kernel patch hopefully soon.  We
>> believe that even though the kernel does not need the additional
>> information about the constraint, the limited space required to carry
>> this information makes sense.
>> 
> 
> 
> Can we though make that information opt-in
> 
> I think it annoying that when i run audit2allow my screen gets filled with
> all kinds of information i am not interested in
> 
> I could find a option to get rid of the noise
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
Well I think it should be opt out.

You could easily make a script to do this, something like:

audit2allow $@ | grep ^allow

But it is something I would like to add.

audit2allow -q

Or something like that.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpTYsACgkQrlYvE4MpobOnwACfeTrGTGApAl16dUInFwydpa7M
qfYAniJOtt5Yq2hAHgCMgOKH+MriOwj7
=g/bx
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
