Subject: Re: The sort algorithm is broken by the second rule,  We need a
	way to pin these rules to the top.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442D436A.1010805@tresys.com>
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 10:10:46 -0500
Message-Id: <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-31 at 09:57 -0500, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > /usr(/.*)?/lib(64)?(/.*)?            
> > gen_context(system_u:object_r:lib_t,s0)
> > /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*    --    
> > gen_context(system_u:object_r:shlib_t,s0)
> > 
> > The following has to follow the one above.
> > 
> > /usr/lib(64)?/libglide3\.so.*         --    
> > gen_context(system_u:object_r:textrel_shlib_t,s0)
> > 
> > 
> > It did in FC4, now it does not.  This is the second bug I have seen 
> > caused by the sort algoritm.  We need a way to secify a primary File 
> > Context file that will not be sorted but will always be at the top.  
> > Then the rest can be sorted.
> > 
> > Maybe we do not sort files within a particular fc file.  I do not know. 
> > but this is broken.
> > 
> 
> We are preparing to send up a patch that adds file context ordering to 
> libsemanage ala the algorithm in fc_sort.c in refpolicy/support. The 
> sort algorithm should put the 3rd entry below the top two because the 
> stem length is greater. Are you seeing this with strict (and hightly 
> modular policy?) the large base.pp from targeted will already have its 
> file context entries sorted by fc_sort.c and should handle this case.

Running fc_sort from refpolicy on the following input:
/usr(/.*)?/lib(64)?(/.*)?            gen_context(system_u:object_r:lib_t,s0)
/usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*    --  gen_context(system_u:object_r:shlib_t,s0)
/usr(/.*)?/nvidia/.*\.so(\..*)?        --   gen_context(system_u:object_r:textrel_shlib_t,s0)
/usr/lib(64)?/libglide3\.so.*         --    gen_context(system_u:object_r:textrel_shlib_t,s0)

yields the following output:
/usr(/.*)?/lib(64)?(/.*)?               gen_context(system_u:object_r:lib_t,s0)
/usr(/.*)?/nvidia/.*\.so(\..*)?         --      gen_context(system_u:object_r:textrel_shlib_t,s0)
/usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*            --      gen_context(system_u:object_r:shlib_t,s0)
/usr/lib(64)?/libglide3\.so.*           --      gen_context(system_u:object_r:textrel_shlib_t,s0)

So the nvidia entry loses (this was separately reported), but the
libglide entry should be ok (last matching entry wins).  Yes?

At present, you can force the nvidia entry to win by adding it as a
local fcontext via semanage or file_contexts.local.  But if we add the
sort to libsemanage, we'll lose the ability to give precedence to local
fcontexts added by semanage unless we exclude the local ones from the
sort, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
