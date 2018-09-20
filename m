Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K8n58v027193
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 04:49:06 -0400
From: David Laight <David.Laight@aculab.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>, LSM
 <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, "SE Linux" <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 "John Johansen" <john.johansen@canonical.com>, Kees Cook
 <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Alexey
 Dobriyan" <adobriyan@gmail.com>, =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Thu, 20 Sep 2018 08:51:09 +0000
Message-ID: <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
In-Reply-To: <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: RE: [PATCH v3 09/16] SELinux: Abstract use of file security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler
> Sent: 20 September 2018 01:21
> 
> SELinux: Abstract use of file security blob
> 
> Don't use the file->f_security pointer directly.
> Provide a helper function that provides the security blob pointer.
...
> +static inline struct file_security_struct *selinux_file(const struct file *file)
> +{
> +	return file->f_security;
> +}
> +

Why?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
