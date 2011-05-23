Subject: RE: A few questions about module compile/link source code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: method@manicmethod.com, selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w89229AB55B95D9E7630B7AB720@phx.gbl>
References: <SNT139-w488BAEE329DEC249677A49AB890@phx.gbl>
	 ,<4DD5C051.1000203@manicmethod.com>
	 <SNT139-w89229AB55B95D9E7630B7AB720@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 May 2011 09:46:32 -0400
Message-ID: <1306158392.2262.11.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-05-23 at 13:15 +0000, HarryCiao wrote:
> Hi Joshua,
>  
> Many thanks for your response! Hope you had an enjoyable vacation :-)
>  
> Well, for the init_parser() problem, so far I am new to lex & yacc, I
> am most puzzled that some rules are handled when pass == 1 and the id
> queue is purged when pass == 2, whereas some other rules are
> handled when pass == 2 and the id queue got cleaned up when pass == 1.
>  
> Who decides when a particular rule should be processed and when the id
> queue should be cleaned ? and does it and how does it relate with the
> syntax of a certain rule ?

Hi Harry,

The 2nd pass in checkpolicy was introduced long ago (the original CVS
tree shows it as happening 2000.09.19) in order to relax some of the
ordering requirements in the policy configuration.  It allows
checkpolicy to collect up some definitions in the first pass before it
performs any rule expansion, e.g. so that all type attributes are known
before any allow rules are expanded.  More traditionally this would be
done by generating an AST and then just walking the AST for subsequent
passes rather than re-parsing the original source on each pass.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
