Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5L5Uu2M005417
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 01:30:56 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5L5UtPu011566
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 05:30:55 GMT
Date: Thu, 21 Jun 2007 01:30:52 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: nfsv4@linux-nfs.org, Karl MacMillan <kmacmill@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Chris Vance <Christopher.Vance@sparta.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <Line.LNX.4.64.0706201841160.25962@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0706210114560.28076@localhost.localdomain>
References: <Line.LNX.4.64.0706201635280.25279@localhost.localdomain>
 <20070620220201.GL3302@fieldses.org> <Line.LNX.4.64.0706201841160.25962@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Jun 2007, James Morris wrote:

> > >     SENFS will not support this initially in Full Mode, although for Guest
> > >     Mode, the server may convey locally generated security labels to the
> > >     client.
> > 
> > I don't understand.
> 
> If my understanding of multi-server name spaces & referrals is correct, 
> then the NFS server may be exporting a filesystem from another machine as 
> if it was its own.
> 
> In this case, we won't initially try and solve the potential SELinux 
> issues here (e.g. conveying SELinux state between multiple parties, and 
> across multiple security boundaries), and instead just allow the server to 
> assign labels to the filesystem itself.  This would likely be some default 
> label for the entire referred fs.

It seems my understanding here is wrong, after re-reading the 4.1 spec.  I 
need to rework this section of the document.




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
