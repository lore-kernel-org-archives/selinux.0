Date: Tue, 20 Aug 2002 07:37:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: Jeremy Kusnetz <JKusnetz@nrtc.org>,
        "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: RE: New to SELinux
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015243F4@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0208200724000.13775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Aug 2002, Westerman, Mark wrote:

> The Sourceforge cvs tree is up to date. Every patch for SELinux Steve
> updates, he updates the sourceforge CVS tree.  The sourceforge cvs tree
> is the updated NSA release.
> When the NSA Releases a new release the sourceforge will be updated at about
> the same time. If you wish to follow close to the NSA releases use the
> sourceforge cvs tree, it only contains patches that have been applied
> to the SELinux project.
>
> http://sourceforge.net/projects/selinux/

Just to clarify, while the sourceforge CVS tree may contain bug fixes and
minor enhancements committed between public releases, we typically do not
merge new base kernel versions into it until after making a new public
release.  Hence, it does not contain a 2.4.19-based kernel yet, and will
not contain a 2.4.19-based kernel until after a new public release is made
with that kernel.

For CVS access, you can use the following:
cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

The NSA public releases of SELinux are imported on the vendor branch,
tagged "nsa".  Bug fixes and minor enhancements may be committed on the
head between releases.  The corresponding patches are posted on the
selinux list, or at least an announcement regarding the patch is posted
depending on the extent of the patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
