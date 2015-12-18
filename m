Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBINttg1007291
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 18:55:55 -0500
Received: by mail-oi0-f47.google.com with SMTP id l9so38888947oia.2
 for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2015 15:55:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E7015520-BD34-47CE-A96C-DD76A6B3EBCC@nall.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
 <56702B25.9010205@tycho.nsa.gov>
 <56703A9E.7000507@schaufler-ca.com>
 <E542E1EE-77B3-4133-B9AC-486256AB7D53@nall.com>
 <567055DA.2070300@tycho.nsa.gov>
 <E7015520-BD34-47CE-A96C-DD76A6B3EBCC@nall.com>
Date: Fri, 18 Dec 2015 18:55:46 -0500
Message-ID: <CAHC9VhQOH0dbQwW80xQTSsXPnEv55ejpDE5vtwxNB0M4--99+A@mail.gmail.com>
Subject: Re: Exposing secid to secctx mapping to user-space
From: Paul Moore <paul@paul-moore.com>
To: Joe Nall <joe@nall.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Casey Schaufler <casey@schaufler-ca.com>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "arve@google.com" <arve@google.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 15, 2015 at 2:09 PM, Joe Nall <joe@nall.com> wrote:
>> On Dec 15, 2015, at 12:03 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Are you patching the kernel to support > 4K contexts?
>> Otherwise, I'd expect you run up against the proc and selinuxfs API limitations (page size) and/or the filesystem xattr storage limitations (block size).
>
> No. The example was a contrived example of what is possible within the format. We use a couple of 2500 byte labels in formal test these days to make sure that we don't have an OS regression. I just get tired of code like this in openswan:
>
> #ifdef HAVE_LABELED_IPSEC
> /* security label length should not exceed 256 in most cases,
>  * (discussed with kernel and selinux people).
>  */
> #define MAX_SECCTX_LEN    257 /* including '\0'*/

So let's just get rid of labeled IPsec ... show of hands? ;)

-- 
paul moore
www.paul-moore.com
