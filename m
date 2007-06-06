Message-ID: <46672974.4080803@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 17:39:00 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Paul Moore <paul.moore@hp.com>, vyekkirala@TrustedCS.com,
        KaiGai Kohei <kaigai@kaigai.gr.jp>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com> <200706061537.49417.paul.moore@hp.com> <466719B7.6090003@manicmethod.com> <200706061648.37402.paul.moore@hp.com> <466724DE.4010302@manicmethod.com>
In-Reply-To: <466724DE.4010302@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> The unfortunate part is that we are going to have all these systems for 
> managing different kinds of external labels, it would be nice if there 
> was a centralized management system, even if the backends are spread all 
> over the place. I don't mean a GUI here either (not that a GUI would be 
> bad) but more along the lines of a central management library that can 
> handle it all that a GUI could later use. I'm not sure if libsemanage is 
> the place for this either, particularly with ipsec where management 
> really means updating SPD entries to have contexts, I don't know how 
> people currently manage SPD entries so I'm not sure where we can 
> interject ourselves without disturbing users..
> 

Maybe libsemanage wrapper layers could be written on top of all the 
various systems that involve SELinux labels.  This would require that 
they all have relatively stable programmatic interfaces though.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
