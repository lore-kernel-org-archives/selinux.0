Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DLcSal016929
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 17:38:28 -0400
Received: from web36601.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DLbleg007224
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 21:37:47 GMT
Message-ID: <20061013213819.37747.qmail@web36601.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 14:38:19 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: context_sensitivity_{get|set}
To: selinux@tycho.nsa.gov
In-Reply-To: <1160769832.14346.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> >From the TCSEC glossary:
> 	"Security Level - The combination of a hierarchical
> classification and
> a set of non-hierarchical categories that represents
> the sensitivity of
> information."
> 
> >From Bell and LaPadula's Secure Computer Systems: 
> Unified Exposition
> and Multics Interpretation:
> 	"A total security designation is a pair:
> 		(classification, set of categories).
> 	 Such a pair we call a "security level.""

>From FIPS188:

security label - A marking bound to a resource
(which may be a data unit) that names or
designates the security attributes of that
resource [2].

security level - A hierarchical indicator of
the degree of sensitivity to a certain threat.
It implies, according to the security policy
being enforced, a specific level of protection.


>From Telecom Glossary 2K
( http://www.atis.org/tg2k/_security_label.html )

security label: Information representing the
sensitivity of a subject or object, such as its
hierarchical classification ("confidential," "secret,"
"top secret") together with any applicable
nonhierarchical security categories (e.g., sensitive
compartmented information, critical nuclear weapon
design information).
[INFOSEC-99] Synonym security classification. 


I suppose that we could throw quotes at each
other all day and in the end neither would
convince the other.

In the Unix MLS world everyone calls the
hierarchical part the level and the whole
thing the label. It is entirely possible
that such usage is incorrect.

Well, call it what you will. I gave it my shot.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
