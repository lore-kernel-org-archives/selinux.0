Subject: Re: issue on binary & source compatibility
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040601133457.24158.qmail@web51508.mail.yahoo.com>
References: <20040601133457.24158.qmail@web51508.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1086179625.15871.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Jun 2004 08:33:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-06-01 at 09:34, Park Lee wrote:
> Today,I saw an article named 'An Overview of Security Enhanced Linux'
> at http://www.kuro5hin.org/story/2001/6/17/0104/24701.
> 
> It says: At present SE Linux provides binary compatibility with
> existing applications, and source compatibility with kernel modules.
>  
> Then, I want to ask what the meaning and differences of 'binary
> compatibility' and 'source compatibility' are? and why it said so?

That article is dated June 2001, so it is rather old.  The compatibility
discussion is apparently taken from our FAQ, i.e.
http://www.nsa.gov/selinux/info/faq.cfm#I7.  Source compatibility for
kernel modules means that you don't need to modify the kernel module
sources, but you do need to rebuild them against the modified kernel
headers so that they pick up the extended kernel data structures that
include security fields.  However, with the integration of LSM into the
mainline kernel, any kernel modules built against the mainline kernel
will pick up the extended kernel data structures automatically.  Hence,
the answer in the FAQ (and that article) is out of date; kernel modules
should be binary compatible as well.  

Of course, some kernel modules may not interact well with SELinux
without modification, e.g. if they directly allocate and set  up kernel
objects without using the normal core kernel initialization functions,
then you could end up with kernel objects that lack proper security
information.  Some kernel modules may also lack proper security controls
(or sufficiently fine-grained controls) over their operations; since LSM
does hook capable() and permission(), SELinux can at least mirror all
such checks performed by modules, but this may not always be adequate.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
