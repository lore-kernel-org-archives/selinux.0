MIME-Version: 1.0
In-Reply-To: <52B2190F.1020100@tycho.nsa.gov>
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
 <52B20217.8030908@tycho.nsa.gov>
 <CACVacMszVX7Yuv1rcuzphQ2YXXCABMb2aQ1CY3zcoaiNmoqHYw@mail.gmail.com>
 <52B2190F.1020100@tycho.nsa.gov>
Date: Wed, 18 Dec 2013 13:55:47 -0800
Message-ID: <CACVacMv_03+PW1oVfXM1O234CmsqGUbKWMWtB3ZnkWyN--d2Bw@mail.gmail.com>
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
From: Jay Corrales <jscorrales1122@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/18/13, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/18/2013 04:46 PM, Jay Corrales wrote:
>> ls -Z shows system_u:object_r:awips_exec_t. If execute_no_trans allow
>> is add, it does not run in the awips_exec_t domain, but in user_t.
>
> Um, what is the file mode, i.e. is it executable?

0755, yes the executable bit is set.
