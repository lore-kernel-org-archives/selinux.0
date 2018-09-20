Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KFR53r016674
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 11:27:05 -0400
To: David Laight <David.Laight@ACULAB.COM>,
 LSM <linux-security-module@vger.kernel.org>, James Morris
 <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
 <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4db0c110-c1aa-aac8-901f-a9abf662b605@schaufler-ca.com>
Date: Thu, 20 Sep 2018 08:20:50 -0700
MIME-Version: 1.0
In-Reply-To: <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 09/16] SELinux: Abstract use of file security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/20/2018 1:51 AM, David Laight wrote:
> From: Casey Schaufler
>> Sent: 20 September 2018 01:21
>>
>> SELinux: Abstract use of file security blob
>>
>> Don't use the file->f_security pointer directly.
>> Provide a helper function that provides the security blob pointer.
> ...
>> +static inline struct file_security_struct *selinux_file(const struct file *file)
>> +{
>> +	return file->f_security;
>> +}
>> +
> Why?

In patch 16/16 this becomes:

 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + selinux_blob_sizes.lbs_file;
+#else
 	return file->f_security;
+#endif
 }

You could hard code this bit everywhere it's used, but that
would be prone to error. I'm not generally an abstractionist
myself, but it these cases abstraction adds value.
