Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1ID73OB008722
 for <selinux@tycho.nsa.gov>; Thu, 18 Feb 2016 08:07:03 -0500
Date: Thu, 18 Feb 2016 13:03:55 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
Message-ID: <1612098262.9892014.1455800635404.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <CAJfZ7=mHdpidBhau1WjnvRFqK+Ln0iJo9GkD5pxq4oxP81E=zg@mail.gmail.com>
References: <CAJfZ7=mHdpidBhau1WjnvRFqK+Ln0iJo9GkD5pxq4oxP81E=zg@mail.gmail.com>
Subject: Re: RESEND [PATCH V3] libselinux: Add selinux_restorecon function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>





On Thursday, 18 February 2016, 10:08, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:


>
>
>On Wed, Feb 17, 2016 at 3:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>On 01/15/2016 11:11 AM, Richard Haines wrote:
>>
>>The selinux_restorecon(3) man page details this function.
>>>
>
>

>About the man page, it defines "int selinux_restorecon(const char ** pathname, unsigned int restorecon_flags)" but the implementation uses only one star for pathname. I guess this is a small typo in the man page, as pathname is considered as a string and not a list of string.

Thanks - You are correct. I'll submit a patch to fix this.
>
>
>Nicolas
>
>
