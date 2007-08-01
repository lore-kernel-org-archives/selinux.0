Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71KthYI029414
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 16:55:43 -0400
Received: from web36611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l71KtgpI023091
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 20:55:42 GMT
Date: Wed, 1 Aug 2007 13:55:37 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <31809.62508.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> This is the first set of patches attempting to provide a generic framework
> for
> MAC labeling in NFSv4.

I've read through the patches and I have one very important issue.
If you are going to provide a "generic" framework you need to support
label representations other than u32. If you only want to support
SELinux, and I understand that that is your initial target, a u32
is fine, but if you want a generic framework you need to allow for
the kinds of labels that have been used elsewhere. Smack (under
review now) uses an 8byte label. Trusted Irix uses a 510byte label,
and although I wouldn't expect that implementation to actually get
ported any time soon it provides an existence proof for large labels.
If you're talking about NFS you need to seriously consider what
TrustedSolaris requires, if just out of courtesy to those who brought
you NFS in the first place.

> This patch set is based heavily off of the patch from
> Sparta that was circulated privately in our discussion. It contains several
> new
> LSM hooks to provide a method for setting the incore inode data and encoding
> security information for passing across the wire in a module independent
> manner. This patch set does not provide a method for setting the label on the
> server from the client but provides the method for encoding those labels on
> the
> client. The patch applies on top of James Morris's SELinux git tree at git
> commit hash 80ba80a9bf25d251237694c3fcee850a73324532. I am currently
> maintaining these patches using guilt so if you have any patches for me to
> add
> to the set or to fold into the current patch set please mail them to the list
> and I will add them to the next round of patches.
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
