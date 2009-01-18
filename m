Date: Mon, 19 Jan 2009 09:52:03 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC v4]Provide a method for detecting labeling support on a
 file system
In-Reply-To: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.1.10.0901190951230.19321@tundra.namei.org>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Jan 2009, David P. Quigley wrote:

> There are two differences between this patch set and version three. The first
> is the string supports_labeling has been replaced with seclabel as labeling is
> to generic of a term with respect to file systems. The second change is that the
> string has been added to the appropriate function in the selinux code such that
> it gets stripped out of the mount options that are eventually handed to the
> file system to parse.

All three patches applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
