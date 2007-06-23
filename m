Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5NJEYFM007574
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 15:14:34 -0400
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5NJEXoq003844
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 19:14:33 GMT
Date: Sat, 23 Jun 2007 12:14:28 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
To: "J. Bruce Fields" <bfields@fieldses.org>, James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>, nfsv4@linux-nfs.org,
        Karl MacMillan <kmacmill@redhat.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        Chris Vance <Christopher.Vance@sparta.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20070623180143.GA7076@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <417775.99905.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "J. Bruce Fields" <bfields@fieldses.org> wrote:

> On Sat, Jun 23, 2007 at 01:45:45PM -0400, James Morris wrote:
> > NFSv4 has named attributes, which are modeled on Solaris subfile-style 
> > extended attributes.  Technically, I think we could emulate Linux style 
> > xattrs over named attributes, but it's ugly:
> 
> Agreed.
> 
> I don't understand the argument against using xattrs for security
> labels, though:

Linux style xattrs work just fine on local file systems, agreed?
Irix xattrs, which are a pretty difficult to distinguish from
Linux xattrs, work on local and remote (NFSv3, CXFS) file systems
and have for years. It seems to me that someone who says you
can't do remote xattrs as an extension of existing protocols
is going to have a tough row to hoe given the existance of the
NFSv3 "helper" protocol I attached earlier and CXFS.

> 
> > 4. SELinux labels, and potentially other kernel-managed Linux xattrs, 
> > require considerably more state than can be conveyed by any simple notion 
> > of attributes over the wire.  xattrs are an appropriate local mechanism 
> > for security labeling, because they provide a consistent API and 
> > filesystem portability.  However, other local security state is also 
> > utilized by the security system, such as the current security label of the 
> > process accessing the file (as opposed to the one which opened it) and its 
> > fscreate attribute.  Once we start to distribute SELinux labeling, it 
> > becomes apparent that we need to a lot more than simply send file labels 
> > over the wire.  In addition to managing volatile client security state, we 
> > need to cater to many other aspects of the system, including but not 
> > limited to: binding SELinux-specific authentication credentials to 
> > operations; allowing the client to obtain SELinux labeling and enforcement 
> > decisions from the server for cached/delegated objects; ensuring 
> > consistency when server policy changes; and conveying audit messages 
> > across the wire.
> 
> This mostly seems to be an argument that we need something more than an
> xattr protocol on its own, which is obviously true.

The SELinux developers have made some design choices that do
not distribute well and require additional mechanism to address.
The attributes stored on an SELinux file system are meaningful
only in relation to the policy against which they are generated.
This has advantages but requires that enforcement engines sharing
the data take steps to ensure consistancy.

An old fashioned MLS label (e.g. one the looks like a CISPO tag)
can be shared more simply, all that is required is a common
understanding between the machines about how users are assigned
levels and categories.

Sharing SELinux labels will require a mechanism similar to IPSEC
in both form and function to make the labels useful. Simpler
labeling models, in which the label is either self contained,
self describing, or obvious do not require that level of
sophistication to safely share label data.

> But I don't
> understand why xattrs couldn't be used just for the purpose of getting
> and setting file labels.  Maybe an example would help me understand the
> problems you're seeing?

They can and have been. It's a solved problem.

The problem is not transportation or storage. There are problems
with protection of the data while it's in transit. There are
problems with the label value stored by the client meaning something
different to the server. 

An interesting aside is that I have seen deployments where an NFS
server running a "vanillia" Unix that supported extended attributes
was used in conjuntion with MLS clients. It worked just fine and
made backups much easier for the overall environment, taking advantage
of the difference in access policy. Not reccomended for the faint of
heart, of course.

I heartily recommend seperating the overall effort into three parts:

1. transportation and storage of general extended attributes.
2. protection and integrity of the information in #1.
3. translation and/or mutual policy enforcement negotiations.

For step 1 I have passed along a worked example.
For step 2 call to 1-800-GOTCRYPTO.
For step 3 you'll most likely want a framework so that machines
with different SELinux policy files or other system differences
(US DoD Secret is not the same as US DoE Secret) can figure out
among themselves who gets to decide on a given access. That, or
a mechanism for translating the attributes as they pass between
machines. Or both.

> > Btw, I will be in Ottawa next week.  Perhaps it might be worth organizing 
> > a lunch or similar for people who are there and interested in discussing 
> > this.
> 
> I'd be interested.--b.

Can't make it (again) this year.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
