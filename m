Date: Fri, 3 Apr 2009 19:31:03 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, "Matthew N. Dodd" <matthew.dodd@sparta.com>,
        trond.myklebust@fys.uio.no, bfields@fieldses.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 08/14] NFSv4: Add label recommended attribute and NFSv4
 flags
In-Reply-To: <1227733394-1114-9-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.00.0904031921320.11240@tundra.namei.org>
References: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov> <1227733394-1114-9-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Nov 2008, David P. Quigley wrote:

> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index ea03667..144eacf 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -21,6 +21,7 @@
>  #define NFS4_FHSIZE		128
>  #define NFS4_MAXPATHLEN		PATH_MAX
>  #define NFS4_MAXNAMLEN		NAME_MAX
> +#define NFS4_MAXLABELLEN	4096

I can't recall if this has been discussed before, but why is the label 
length limited to this value?

SELinux on-disk labels can be up to 64KB in size (XATTR_SIZE_MAX), and I'd 
like to ensure that we don't end up with an unnecessary disk vs. network 
label size incompatibility.

While it seems unlikely that SELinux (and other forms of MAC) security 
labels would currently exceed 4K, we don't know how SELinux might be 
extended in the future, and should avoid limiting label flexibility 
beyond existing constraints.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
