Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0QKGnMV000851
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 15:16:49 -0500
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0QKGmwL025516
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 20:16:48 GMT
Received: by wwb17 with SMTP id 17so1399160wwb.30
        for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 12:16:47 -0800 (PST)
Message-ID: <4D40812C.4060004@gmail.com>
Date: Wed, 26 Jan 2011 21:16:44 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "Ger Lawlor (gelawlor)" <gelawlor@cisco.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SeLinux Policy design question
References: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>
In-Reply-To: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/26/2011 07:16 PM, Ger Lawlor (gelawlor) wrote:
> Hi,
> 
>  
> 
> I am pondering the best approach to design of appropriate filesystem
> labeling that will reduce the long term complexity of managing contexts
> and transitions in SeLinux.
> 
> If I have a suite of services that interface within a single product and
> those services have the potential to share access to similar sub
> directory structures, but they 
> 
> currently only access files and execute within their own install
> directories. It's obviously better to keep locked down any access
> outside of each services domain. 
> 
> However, what if all services within a product were permitted open
> access to all known directories within a product - apart from the
> obvious i.e. these services could
> 
> Interfere with each other, are there any reasons why this approach would
> not be considered a suitable initial approach to seLinux development,
> with continued 
> 
> Evolution, adding contexts for further refinement of control over time?
> Are there best practice guides to filesystem labeling that considers the
> complexity that can
> 
> Come from excessive labeling?

In my experience it is probably easier and safer to design policy as
fine grained as you need to initially. Because it is in my experience
easier to allow a restricted domain some extra permissions over time
that it may need later than it is to restrict generic domain for a
particular process.

For example:

Lets say you start as generic as possible and create a single domain
where all the services in your suite runs in. That means that this
single generic domain needs all permissions required to allow each
service to function properly.

Then later you decide to create a new domain for one of the services in
your suite. That service requires a unique permission. That would then
mean that your initial generic domain can drop that permission. Because
the service that needs it now runs in its own domain with its own
permission set.

In theory if you know that the permission in question is unique then its
easy to just remove that from the generic domain, however in practice it
is not that easy to determine that it is unique and only required by a
specific service.

And so chances are that the initial generic domain becomes more
permissive than it has to be.

If this only applies to a single domain, then this is not such a big
deal, because once you got to confining each other service in your suite
over time, you could just revisit the initial more generic domain.

But the more generic confined domains you have the harder it gets.

It is in my view i guess a balance of priorities. I would probably keep
my policy under development until i reached all my security goals, and
then deploy it. But you may not have this luxury.

You can choose you start with some generic domain to dump all your
targeted processes in and refine policy later but basically you may end
up with extra work, just to be able to basically deploy an unfinished
policy.

Besides in either case you run the risk of having to maintain policy
over time any ways.

But as for overall, keep it as generic as possible to reduce complexity,
but not at the cost of not meeting your security goals.
Because that's eventually what it is all about (meeting all your
security goals.

Disclaimer: I am not a professional security expert and so my
suggestions may be fundamentally wrong. Use my advice at your own risk.

>  
> 
> Thanks.
> 
> Ger.
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1AgSsACgkQMlxVo39jgT8sPgCfTurKF2uof7bYDPG01Mwb+54X
nNsAoLFJNtd/+NYh0NwwL8krb6iDmAqs
=IuF6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
