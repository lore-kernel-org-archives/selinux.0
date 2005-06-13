Message-ID: <20050613141014.17870.qmail@web31608.mail.mud.yahoo.com>
Date: Mon, 13 Jun 2005 07:10:14 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050613100158.GA6610@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
wrote:


> > You will do well to consider the implications
> > of allowing anything other than identical policies
> > within a cluster or even a grid. 
> 
>  okay.
> 
>  simplistic view: in nt-land, you have local
> workstations
>  'policy' and you have a global 'policy'.

The "one policy" ought to allow for the 
differentiation between local and global
without resorting to naming each individual
machine explicitly. Clusters typically name
the nodes dynamicaly after all.

>  in this way you have a scheme whereby the
> workstation is still
>  to some extent useable / recoverable even when
> disconnected
>  (isolated) from the domain.

Does it make sense for a machine that is part
of a global "system" to have a policy that is
potentially inconsistent with the whole? Maybe.
Your are definitely getting into one of the areas
that can cause trouble. User Wilma defined in
two places differently because there are two of
her. Since users are in the policy, you have a
sticky issue.


>  even though it's access-control based, there is
> much to be
>  learned from the application of microsoft's nt
> domain protocol.

Learning from the experience of
others is for squares.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
