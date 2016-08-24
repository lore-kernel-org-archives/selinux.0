Subject: Re: Embedded SELinux: SELinux via NFS with different policies on
 client and server
To: Ralf Spenneberg <ralf@os-t.de>, Selinux@tycho.nsa.gov
References: <f805c577-6238-d99d-bd9d-5e1f63f6371e@os-t.de>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <87af2abc-ebfc-ffaf-7c7e-850c0cf566e9@tycho.nsa.gov>
Date: Wed, 24 Aug 2016 08:48:21 -0400
MIME-Version: 1.0
In-Reply-To: <f805c577-6238-d99d-bd9d-5e1f63f6371e@os-t.de>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/24/2016 08:14 AM, Ralf Spenneberg wrote:
> Hi
> 
> we are working on SELinux in the embedded area. For development we are
> using a nfsroot based approach. We successfully setup the nfs server
> supporting security labels and are able to boot from the share using
> nfsroot. We would like to label the files from the server so the relabel
> process on the client may be omitted.
> The embedded device requires a different policy that the nfs-server.  We
> are basing our policy on the refpolicy-2.20151208 and only compile the
> required modules.
> 
> When setting any label on the server the client always displays
> unlabeled_t. The same happens if we set the label on the client. The
> server displays unlabeled_t. Is there a way that both might agree on the
> same label?
> By the way: The server is x86_64 (kernel 4.5.7) while the client is
> armv7l 32bit (3.12.10).
> 
> But since the labels are stored in text this should not pose any
> problems, does it?

Correct.  You said that they require a different policy.  Is one running
a MLS-enabled (MCS or MLS) policy, while the other is not?  Or is the
user/role/type you are using in the label defined in both policies?

Look at your dmesg output on both the client and server for messages
from SELinux, e.g.
SELinux: inode=... on dev=... was found to have an invalid context=...
This indicates you may need to relabel the inode or the filesystem in
question.
