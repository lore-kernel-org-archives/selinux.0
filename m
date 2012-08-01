Message-ID: <1343822161.20926.6.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Cloning Android repo's from bitbucket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 01 Aug 2012 07:56:01 -0400
In-Reply-To: <CAFftDdoOfz1MVsFKqa3ymCs_+pLhmZWVtrV=HRYzAT-LTA=aLA@mail.gmail.com>
References: 
	<CAFftDdoBpZ9ruMjnBwiA9Cxh0L14xJiXh5LXam3V=n-jHTbYkg@mail.gmail.com>
	 <1343737896.13704.2.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdoOfz1MVsFKqa3ymCs_+pLhmZWVtrV=HRYzAT-LTA=aLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-31 at 18:46 -0700, William Roberts wrote:
> Stephen,
> It didn't like the fetch url, this patch fixes it on master.
> 
> diff --git a/local_manifest.xml b/local_manifest.xml
> index b3d6b49..ba7118d 100644
> --- a/local_manifest.xml
> +++ b/local_manifest.xml
> @@ -1,6 +1,6 @@
>  <manifest>
>    <remote  name="bitbucket"
> -           fetch="git@bitbucket.org:seandroid" />
> +           fetch="git+ssh://git@bitbucket.org/seandroid/" />
> 
>    <remove-project name="platform/external/libselinux"/>
>    <project path="external/libselinux" remote="bitbucket"
> name="external-libselinux"/>

Thanks, fixed on all three branches.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
