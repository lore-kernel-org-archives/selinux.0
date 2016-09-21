Subject: Re: unlocked stdio
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "'seandroid-list@tycho.nsa.gov'" <seandroid-list@tycho.nsa.gov>,
 "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <32dd55fe-ff71-c6ea-8f00-f552d9523676@tycho.nsa.gov>
Date: Wed, 21 Sep 2016 16:08:21 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2016 03:57 PM, Roberts, William C wrote:
> Correction, it’s just fgets_unlocked, it appears to support the others.

Seems like a bug in bionic, but we can work around it by:
#ifdef ANDROID
#define fgets_unlocked(x) fgets(x)
#endif

in selinux_internal.h or some similar internal header.

It avoids unnecessary locking overheads when dealing with FILE
descriptors that are only used locally and guaranteed to not be shared
by multiple threads.

> 
>  
> 
> *From:* Roberts, William C
> *Sent:* Wednesday, September 21, 2016 12:53 PM
> *To:* 'seandroid-list@tycho.nsa.gov' <seandroid-list@tycho.nsa.gov>;
> 'selinux@tycho.nsa.gov' <selinux@tycho.nsa.gov>; 'sds@tycho.nsa.gov'
> <sds@tycho.nsa.gov>
> *Subject:* unlocked stdio
> 
>  
> 
> What was the purpose of using unlocked stdio in libselinux? Bionic
> doesn’t support it, is it really necessary?
> 
>  
> 
> Bill
> 
>  
> 
