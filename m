Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KNYFAt026050
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 19:34:15 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5KNYD1M003203
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 23:34:14 GMT
Date: Wed, 20 Jun 2007 19:34:10 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: selinux@tycho.nsa.gov, nfsv4@linux-nfs.org,
        Karl MacMillan <kmacmill@redhat.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        Chris Vance <Christopher.Vance@sparta.com>,
        Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <20070620220201.GL3302@fieldses.org>
Message-ID: <Line.LNX.4.64.0706201841160.25962@localhost.localdomain>
References: <Line.LNX.4.64.0706201635280.25279@localhost.localdomain>
 <20070620220201.GL3302@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Jun 2007, J. Bruce Fields wrote:

> On Wed, Jun 20, 2007 at 04:49:45PM -0400, James Morris wrote:
> >     SENFS should support authentication on a per-domain granularity so that
> >     different domains running on a client can use different cryptographic
> >     keys and facilities.
> 
> Sorry, I'm not totally sure I understand what a "domain" is. I assume
> every rpc call will need to be associated with a domain?  (Just one, or
> is it every more than one?)  If you need a different credential for each
> domain, what kind of access control do you need for those credentials?

A domain in SELinux refers to a process running in a specific security 
context (i.e. with a specific security label).  Processes running in the 
same domain are considered equivalent by SELinux from a security point of 
view.

An example of the above is that a process labeled as "unclassified" might 
not have access to the same keying material as a process labeled as 
"secret", and the system needs to differentiate on that basis.

Generally, the SELinux credentials need to be used as factors in 
authentication when providing NFS access.

Each RPC call would be associated with an individual process on the 
client, although SELinux would only make use of the SELinux labels, which 
are applied at domain granularity.

Per-domain access control needs to cover all security-relevant aspects of 
the interaction, and would be configured in SELinux security policy.

> > 3.9.  Domains of Interpretation
> > 
> >     In SELinux, a Domain of Interpretation (DOI) represents an
> >     administrative security boundary, where all systems within the DOI have
> >     semantically coherent labeling.  That is, a security label must always
> >     mean exactly the same thing anywhere within the DOI.  An SELinux DOI
> >     may be further demarcated for any other administrative purpose.
> 
> Does the current SELinux have any notion of a DOI?

DOI is an attribute negotiated and used by the IPsec labeled networking in 
SELinux.

> Would it be possible to ignore this problem in a first implementation,
> and just assume the client and server are always in the same DOI?

We want to build DOI support in from the start, rather than try and add it 
later.  Identifying and checking DOIs is not difficult, although things 
like translation can be (and this aspect will not be mandatory).

> > 3.14.  Namespace Access
> > 
> >     The server should provide a means to authorize selective access to the
> >     exported filesystem namespace based upon client credentials and
> >     according to security policy.
> 
> Could you give an example?  Why is this necessary, and how does it go
> beyond the ordinary access control used for files in the exported
> filesystems?

Good point -- in general, SELinux access control would simply handle this 
correctly.

There are cases, though, where multi-level security folk might want to 
either hide part of the namespace completely, or even present a different 
view, based on the client domain.  e.g. domains labeled as 'unclassified' 
objects only see:

server:/export
       |-- rfcs
       |-- usenet

while domains labeled as 'secret' only see:

server:/export
       |-- memos


In the MLS world, this kind of thing is a common requirement (where it's 
sometimes referred to as multilevel directories, or more generally, 
polyinstantiation).


> > 3.15.  External Remote Filesystems
> > 
> >     Under NFSv4, filesystems located externally to the server may be
> >     exported in the same namespace as locally exported filesystems.
> 
> You're thinking of referrals here, or something else?

Yes.

> >     SENFS will not support this initially in Full Mode, although for Guest
> >     Mode, the server may convey locally generated security labels to the
> >     client.
> 
> I don't understand.

If my understanding of multi-server name spaces & referrals is correct, 
then the NFS server may be exporting a filesystem from another machine as 
if it was its own.

In this case, we won't initially try and solve the potential SELinux 
issues here (e.g. conveying SELinux state between multiple parties, and 
across multiple security boundaries), and instead just allow the server to 
assign labels to the filesystem itself.  This would likely be some default 
label for the entire referred fs.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
