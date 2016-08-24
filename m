To: Selinux@tycho.nsa.gov
From: Ralf Spenneberg <ralf@os-t.de>
Subject: Embedded SELinux: SELinux via NFS with different policies on client
 and server
Message-ID: <f805c577-6238-d99d-bd9d-5e1f63f6371e@os-t.de>
Date: Wed, 24 Aug 2016 14:14:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi

we are working on SELinux in the embedded area. For development we are
using a nfsroot based approach. We successfully setup the nfs server
supporting security labels and are able to boot from the share using
nfsroot. We would like to label the files from the server so the relabel
process on the client may be omitted.
The embedded device requires a different policy that the nfs-server.  We
are basing our policy on the refpolicy-2.20151208 and only compile the
required modules.

When setting any label on the server the client always displays
unlabeled_t. The same happens if we set the label on the client. The
server displays unlabeled_t. Is there a way that both might agree on the
same label?
By the way: The server is x86_64 (kernel 4.5.7) while the client is
armv7l 32bit (3.12.10).

But since the labels are stored in text this should not pose any
problems, does it?

Kind regards,

Ralf

-- 
OpenSource Training Ralf Spenneberg     http://www.os-t.de
Am Bahnhof 3-5                          48565 Steinfurt         Germany
Fon: +49(0)2552 638 755                 Fax: +49(0)2552 638 757
