Message-ID: <1343678420.2346.186.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Is the CIL project still active
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: jwcart2@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Jeremy
 Solt <jsolt@tresys.com>, selinux@tycho.nsa.gov
Date: Mon, 30 Jul 2012 16:00:20 -0400
In-Reply-To: <1343673383.28025.YahooMailClassic@web87701.mail.ir2.yahoo.com>
References: <1343673383.28025.YahooMailClassic@web87701.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 19:36 +0100, Richard Haines wrote:
> Regarding the mlsconstrain reverse order problem:
> 
> I've taken one example from the sepolicy and my corresponding entry
> in CIL format. As you can see the generated output is different but
> I'm not sure what is actually generated in the binary policy file.
> 
> sepolicy from seandroid repository - mls file entry:
> mlsconstrain process { transition dyntransition }
> 	     ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);
> 
> The entry generated in the policy.conf file:
> mlsconstrain process { transition dyntransition }
> 	     ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);
> 
> I generated this entry in the mls CIL file using the CIL format:
> (mlsconstrain (kernel.process (transition dyntransition))
>     (and (or (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject)))

I think that should be:
      (or (and (eq h1 h2) (eq l1 l2)) (eq t2 mlstrustedsubject)))

That would be the prefix notation.

> 
> The entry generated in the policy.conf file is:
> mlsconstrain kernel.process { transition dyntransition };
> 	(((h2 eq h1) or (l2 eq l1)) and (mlstrustedsubject eq t1));
> 
> As you can see the (xx eq yy) entries are reversed and the 'or' is
> first with the 'and' second. It could be that I've mis-understood the
> CIL format.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
