Message-ID: <543D36DC.8060202@tycho.nsa.gov>
Date: Tue, 14 Oct 2014 10:44:44 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: fs_use_trans
References: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>
In-Reply-To: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/10/2014 07:05 PM, William Roberts wrote:
> The docs for fs_use_trans state:
> 
> The fs_use_trans statement is used to allocate a security context to
> pseudo filesystems such as pseudo terminals and temporary objects. The
> assigned context is derived from the creating process and that of the
> filesystem type based on transition rules.
> 
> 
> Can someone give me an example? For instance if I had:
> 
> fs_use_trans devpts u:object_r:devpts:s0;
> 
> and a daemon running with context:
> u:r:init:s0
> 
> and it creates something on the devpts, what is the resulting context
> of the object?

It depends on whether you have a type_transition rule defined in policy.
For example, in the Android policy, we have the create_pty() macro
defined in te_macros, and if you had create_pty(init) in your policy,
then it would set up a type transition so that any pty created by init
would be labeled with a init_devpts type rather than just devpts.
