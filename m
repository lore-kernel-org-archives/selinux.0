Message-ID: <4DF10E7D.7050300@manicmethod.com>
Date: Thu, 09 Jun 2011 14:18:37 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: Why user/type/role identifiers duplicated to a block/decl's symtab?
References: <SNT139-W1384F568BE81D383A4C10BAB7C0@phx.gbl>
In-Reply-To: <SNT139-W1384F568BE81D383A4C10BAB7C0@phx.gbl>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HarryCiao wrote:
> Hi Joshua and Stephen,
> 
> I happened to have one more question about the link & expand process.
> 
> Now that once the link process is complete, the base.p_xxx tables would be 
> "complete", that is, it would not only contain all identifiers defined in p_xxx 
> tables of all modules(AKA, the global block of a module), but also all 
> identifiers defined in avrule_decl_t.symtab[] for all block/decl of all modules.
> 

Sorry for the late response, I think the PDF caused this to go to my spam folder...

It wasn't strictly necessary to have full symbol tables per avrule_block in
order to track declaration and requiring symbols but they were used because the
hash table implementation and all supporting functions were already present in
the library. In retrospect this could be a source of excess memory consumption
and module size on disk but it was simply easier and faster to implement at the
time.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
