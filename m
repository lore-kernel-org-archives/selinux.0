Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2TEcWSL003572
	for <selinux@tycho.nsa.gov>; Fri, 29 Mar 2013 10:38:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 29 Mar 2013 10:38:29 -0400
From: David Quigley <dpquigl@davequigley.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Steve Dickson <steved@redhat.com>,
        Trond Myklebust
 <trond.myklebust@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        "David
 P. Quigley" <dpquigl@tycho.nsa.gov>,
        Linux NFS list
 <linux-nfs@vger.kernel.org>,
        Linux Security List
 <linux-security-module@vger.kernel.org>,
        SELinux List
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 13/14] NFSD: Server implementation of MAC Labeling
In-Reply-To: <20130329142331.GA22307@fieldses.org>
References: <1364478845-29796-1-git-send-email-SteveD@redhat.com>
 <1364478845-29796-14-git-send-email-SteveD@redhat.com>
 <20130328185845.GI7080@fieldses.org> <20130328191918.GA14748@fieldses.org>
 <51550B67.40108@davequigley.com> <20130329142331.GA22307@fieldses.org>
Message-ID: <f82b93c023fdaaf4a466317582a783e5@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/29/2013 10:23, J. Bruce Fields wrote:
> On Thu, Mar 28, 2013 at 11:32:55PM -0400, Dave Quigley wrote:
>> On 3/28/2013 3:19 PM, J. Bruce Fields wrote:
>> >Dave, I think these are both questions for you?
>> >
>> >--b.
>> >
>> >On Thu, Mar 28, 2013 at 02:58:45PM -0400, bfields wrote:
>> >>On Thu, Mar 28, 2013 at 09:54:04AM -0400, Steve Dickson wrote:
>> >>>@@ -1988,6 +2044,50 @@ nfsd4_encode_aclname(struct svc_rqst 
>> *rqstp, struct nfs4_ace *ace,
>> >>>  			      FATTR4_WORD0_RDATTR_ERROR)
>> >>>  #define WORD1_ABSENT_FS_ATTRS FATTR4_WORD1_MOUNTED_ON_FILEID
>> >>>
>> >>>+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>> >>>+static inline __be32
>> >>>+nfsd4_encode_security_label(struct svc_rqst *rqstp, struct 
>> dentry *dentry, __be32 **pp, int *buflen)
>> >>>+{
>> >>>+	void *context;
>> >>>+	int err;
>> >>>+	int len;
>> >>>+	uint32_t pi = 0;
>> >>>+	uint32_t lfs = 0;
>> >>>+	__be32 *p = *pp;
>> >>>+
>> >>>+	err = 0;
>> >>>+	(void)security_inode_getsecctx(dentry->d_inode, &context, 
>> &len);
>> >>>+	if (len < 0)
>> >>>+		return nfserrno(len);
>> >>>+
>> >>>+	if (*buflen < ((XDR_QUADLEN(len) << 2) + 4 + 4 + 4)) {
>> >>>+		err = nfserr_resource;
>> >>>+		goto out;
>> >>>+	}
>> >>>+
>> >>>+	/* XXX: A call to the translation code should be placed here
>> >>>+	 * for now send 0  until we have that to indicate the null
>> >>>+	 * translation */
>> >>
>> >>Could we better a better comment here?
>>
>> We could remove this comment all together if you want. We're trying
>> to indicate that at some point in the future there will be a label
>> translation facility like idmapd but for labels instead. This is
>> where the call would go if we had it. I had a basic version of the
>> code a long time ago and that is where I had the call but there was
>> way too much work to make it usable for now. Instead I just pass the
>> null translation indicator on the wire and we wave our hands and say
>> don't look at the man behind the curtain.
>
> So how about just:
>
> 	/*
> 	 * For now we use a 0 here to indicate the null translation; in
> 	 * the future we may place a call to translation code here.
> 	 */
>

Works for me.

>>
>> >...
>> >>>+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>> >>>+__be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct 
>> svc_fh *fhp,
>> >>>+		struct nfs4_label *label)
>> >>>+{
>> >>>+	__be32 error;
>> >>>+	int host_error;
>> >>>+	struct dentry *dentry;
>> >>>+
>> >>>+	/* XXX: should we have a MAY_SSECCTX? */
>> >>
>> >>Again: could we get an answer to this question?
>>
>> I'm pretty sure we can just remove that comment. It was a question
>> from about 5 years ago now and I never found a compelling reason to
>> say yes to it.
>
> OK, let's remove the comment.
>

Agreed
> --b.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
