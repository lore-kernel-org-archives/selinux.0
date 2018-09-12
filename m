To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Daniel J Walsh <dwalsh@redhat.com>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
 <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
 <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
 <CAFPpqQE1x7oS0R21Fm_tU=1XHRy46FEz=ii-QHS9YDE=KAE7Sg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5a423dc6-6667-772a-4715-64fd23fb8378@tycho.nsa.gov>
Date: Wed, 12 Sep 2018 09:57:20 -0400
MIME-Version: 1.0
In-Reply-To: <CAFPpqQE1x7oS0R21Fm_tU=1XHRy46FEz=ii-QHS9YDE=KAE7Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/12/2018 09:26 AM, Ted Toth wrote:
> 
> 
> On Wed, Sep 12, 2018 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 09/11/2018 04:59 PM, Ted Toth wrote:
>      > That's awesome and now it's got me thinking about other
>      > classes/permissions that we could implement. Can cil macros can be
>      > referenced in .te/.if files?
> 
>     Not sure I understand your question.  You can't directly embed cil
>     statements in .te/.if files.  However, if you define a class/permission
>     in a .cil module, you can certainly specify a require on it and use it
>     from a conventional .te/.if module, ala:
>     $ cat > usemcstrans.te <<EOF
>     policy_module(usemcstrans, 1.0)
> 
>     require {
>              class mcstrans { color_use };
>              attribute domain;
>     }
> 
>     allow domain self:mcstrans color_use;
>     EOF
> 
>     $ make -f /usr/share/selinux/devel/Makefile usemcstrans.pp
>     $ sudo semodule -i usemcstrans.pp
> 
> 
> If the cil contained:
> 
> (macro use_color (type caller) (allow caller self mcstrans (color_use)))
> 
> then in x.te can I use the macro:
> 
> type x_t;
> use_color(x_t)

Sorry, no.  The macros used in .te/.if files are just m4 definitions 
handled at the preprocessing stage, not a feature of the module 
language.  The CIL macros are directly supported by the CIL compiler, 
but they won't be visible to the module compiler.  Also, you are missing 
several parentheses above (I'm not fond of the lisp-like syntax myself). 
  In a CIL module, I think the correct syntax would be:

(macro use_color ((type caller)) (allow caller self (mcstrans (color_use))))

(call use_color(x_t))

Or you could define a m4 macro in an .if file and use that in a .te 
file.  Or both.
