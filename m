Message-ID: <20050611172750.41238.qmail@web31601.mail.mud.yahoo.com>
Date: Sat, 11 Jun 2005 10:27:50 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050611103859.34488.qmail@web51505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Park Lee <parklee_sel@yahoo.com> wrote:

> there is an item which says:"Integrate IPSEC with
> network mandatory controls".
> I know that it means:"integration of SELinux and
> IPSEC
> for the purpose of labeling and protecting network
> packets in accordance with security policy".
> 
>      But, Would you please tell me :
> Is there any motivation of doing it? What is the
> significance of doing it? Where to use it? 
> and Is there a scene/scenario for it?

IPSEC is the forward looking mechanism for
passing process attributes between machines.
Without it (or one of the protocols that
preceeded it but have fallen from favor)
there is no way to make access control decisions
on network based communications. You can't
do an MLS cluster, for example, without passing
sensitivity and clearance information among
the machines involved. There are plans afoot
to produce an SELinux based MLS system, and
without networking capabilties the market
opportunity is too small to consider.




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
