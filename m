To: Zvonko Kosic <zkosic@redhat.com>, selinux@tycho.nsa.gov
References: <CAFrfeQ5LmB6bCTT7rP8Afbmvfy8M0MpZwzunfixWA0t_wW4oBQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <35c8119b-046b-ce96-10cc-c7e17ce7d943@tycho.nsa.gov>
Date: Thu, 8 Mar 2018 08:20:23 -0500
MIME-Version: 1.0
In-Reply-To: <CAFrfeQ5LmB6bCTT7rP8Afbmvfy8M0MpZwzunfixWA0t_wW4oBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: SELinux Namespace on bind mounted files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/08/2018 05:55 AM, Zvonko Kosic wrote:
> I've seen the presentation by James Morrison about  namespacing SELinux and I have a question regarding a special case we have in our environment. 
> 
> We have third party prestart runtime hooks for docker which bind mount
> files from the host into the container image, which have the wrong label. 
> 
> To change the SELinux labels on the host is not an option because
> it breaks stuff on the host. 
> 
> Wil the SELinux namespacing work on files that are bind mounted?

I believe the answer is yes, since my patches support per-namespace in-core inode SIDs and James' additional patches support per-namespace on-disk xattrs (so the bind-mounted files can have two distinct labels, one of which will be presented to processes in the root/init namespace and the other to processes within the child namespace).  That said, this is all very much work in progress.
