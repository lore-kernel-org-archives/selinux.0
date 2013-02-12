Message-ID: <511A3B8F.8000702@tycho.nsa.gov>
Date: Tue, 12 Feb 2013 07:54:39 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: systemd selinux
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com> <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com> <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com> <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com> <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com> <51195783.5080201@tycho.nsa.gov> <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com> <51195BFC.3000604@tycho.nsa.gov> <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com> <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com>
In-Reply-To: <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/11/2013 06:01 PM, Brian Iván Martínez wrote:
> Me bothering again, I'm trying to build libselinux 2.1.12 and in the
> make step I get the error undefined pcre_free, pcre_free_study,
> pcre_compile, pcre_study and pcre_exec in the file label_file.c , is
> there a patch to be applied or configuration needed or a bug?

Requires libpcre.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
