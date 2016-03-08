Subject: Re: initial_sid context via libsepol
To: William Roberts <bill.c.roberts@gmail.com>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov> <56DDE54F.4050208@tycho.nsa.gov>
 <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56DED6C6.4000407@tycho.nsa.gov>
Date: Tue, 8 Mar 2016 08:42:30 -0500
MIME-Version: 1.0
In-Reply-To: <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/07/2016 08:32 PM, William Roberts wrote:
>
>
> On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>
>     On 03/07/2016 01:44 PM, Stephen Smalley wrote:
>
>         On 03/07/2016 10:41 AM, Richard Haines wrote:
>
>
>
>
>
>
>                 On Saturday, 5 March 2016, 14:48, Richard Haines
>                 <richard_c_haines@btinternet.com
>                 <mailto:richard_c_haines@btinternet.com>> wrote:
>
>
>
>
>
>                 On Friday, 4 March 2016, 21:18, "Roberts, William C"
>                 <william.c.roberts@intel.com
>                 <mailto:william.c.roberts@intel.com>> wrote:
>
>
>
>
>
>
>                     How can one obtain the same value as
>                     /sys/fs/selinux/initial_contexts/file
>
>                 via libsepol?
>
>
>                     I’ve been digging around libsepol and its not quite
>                     clear to me.
>
>                     It looks as though the record is here:
>                                       context_struct_t *a = &((policydb_t
>
>                 *)pol.db)->ocontexts[OCON_ISID]->context[0];
>
>                                       context_struct_t *b = &((policydb_t
>
>                 *)pol.db)->ocontexts[OCON_ISID]->context[1];
>
>
>                                       printf("%u\n", a->type);
>                                       printf("%u\n",b->type);
>
>                     Prints:
>                     185
>                     0
>
>                     Not sure if this is right, and how to format the
>                     context struct to a
>                     string.
>
>                 I didn’t see any helpers.
>
>
>
>
>
>                 I've attached an example, hope it's useful
>
>
>             I've updated the example with more detail and display SID
>             name using
>             SID value not counter.
>
>
>         Any particular reason you didn't use sepol_sid_to_context()?
>
>
>     I guess context_to_string() on the context structure would work
>     better for your purposes.   sepol_sid_to_context() would require
>     loading the sidtab via policydb_load_isids() and setting the
>     internal policydb to the one you loaded via sepol_set_policydb().
>
>
>
> Seems as though its not exported api, but it does indeed print something:
> code:
> char *s;
> size_t len;
> context_struct_t *a = &((policydb_t
> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>
> int rc = context_to_string(pol.handle, (policydb_t *)pol.db, a, &s, &len);
>
> printf("rc: %d\n", rc);
> printf("con: %s\n", s);
>
> prints:
>    rc: 0
>    con: u:object_r:null_device:s0
>
> However, I am after the initial sid for file, which this isn't it... is
> it in the ocontexts array under a different index?

ocontext[OCON_ISID] points to the head of a linked list of initial SIDs, 
with the values in ->sid[0] and the context structures in ->context[0]. 
  Richard's sample program showed you how to walk it and print out all 
the entries.  The symbolic names themselves aren't in the policydb, as 
he noted; you can grab it from the kernel source 
(linux/security/selinux/include/initial_sid_to_string.h) or from the 
refpolicy (run make in refpolicy/policy/flask and grab 
kernel/initial_sid_to_string.h).
