Subject: Re: Something seems to be self-contradictory
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_2004@yahoo.com.cn>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040216140245.87457.qmail@web15201.mail.bjs.yahoo.com>
References: <20040216140245.87457.qmail@web15201.mail.bjs.yahoo.com>
Content-Type: text/plain
Message-Id: <1077031819.16139.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 10:30:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-02-16 at 09:02, Park Lee wrote:
> Hi,
> Today,I was reading some SELinux technical documents.I saw the
> following words, They seems to be self-contradictory:
>  
> 1.  ... ... A program,like any other object, is assigned a
> type,....      ( Page 4, subsection 3.1.TE Model,  Configuring the
> SELinux Policy).
> 2. ... ...These transitions ensure that system processes and certain
> programs are placed into their own separate domains automatically.
> ......    ( Page 2, section 2 Overview,  A Security Policy
> Configuration for the Security-Enhanced Linux ).
>  
> Then I was confused by such a problem:
> Whether a program is assigned a type or a domain ?
>  
A program (i.e. an executable file) is assigned a type.  A process is
assigned a domain (although in SELinux, a domain is just a type
associated with a process).  So the latter statement isn't quite
accurate; it should be "...system processes and processes that execute
certain programs are placed...".

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
