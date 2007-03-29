Subject: Re: [PATCH] map booleans during expansion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <460BB32F.8070801@manicmethod.com>
References: <1175098597.2062.11.camel@localhost.localdomain>
	 <1175114632.10390.1.camel@localhost.localdomain>
	 <460BB32F.8070801@manicmethod.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 09:42:38 -0400
Message-Id: <1175175758.3864.551.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 08:38 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > [below is a response to an accidentally off-list discussion]
> >
> > On Wed, 2007-03-28 at 12:29 -0400, Stephen Smalley wrote:
> >   
> >> On Wed, 2007-03-28 at 12:16 -0400, Karl MacMillan wrote:
> >>     
> >>> Currently, the expander does not map booleans during expansion.
> >>>       
> > However,
> >   
> >>> it is possible that booleans can be declared in an optional block
> >>> resulting in the need to map the booleans. This patch adds boolean
> >>> mappings to the expander. The same thing likely needs to be done for
> >>> roles and users - Josh, can you confirm
> >>>       
> This is correct, only types are being remapped by the expander. I guess 
> someone didn't think all the extra code to remap all of them was worth 
> it since they are very small namespaces anyway.

So do they need to be remapped or not?

BTW, valgrind shows that the patched code is leaking memory, e.g.
 ==5249== 30,576 bytes in 546 blocks are definitely lost in loss record 8 of 9
==5249==    at 0x4005400: malloc (vg_replace_malloc.c:149)
==5249==    by 0x80570CF: cond_node_create (in /home/sds/obj/usr/bin/checkpolicy)
==5249==    by 0x80607EF: cond_node_copy (in /home/sds/obj/usr/bin/checkpolicy)
==5249==    by 0x80623E6: copy_and_expand_avrule_block (in /home/sds/obj/usr/bin/checkpolicy)
==5249==    by 0x8062B9B: expand_module (in /home/sds/obj/usr/bin/checkpolicy)
==5249==    by 0x804A262: main (checkpolicy.c:538)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
