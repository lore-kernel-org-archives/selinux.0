Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GFPvgA001345
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 11:25:57 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GFGoI8015056
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 15:16:50 GMT
Subject: Re: ANN: SELinux Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <42B18324.6020502@kaigai.gr.jp>
References: <1118871745.18294.28.camel@sgc.columbia.tresys.com>
	 <42B18324.6020502@kaigai.gr.jp>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jun 2005 11:17:23 -0400
Message-Id: <1118935044.18294.75.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-16 at 22:48 +0900, KaiGai Kohei wrote:
> Hi,
> 
> I looked the SELinux Reference Policy lightly.
> I prefer such the approach defines explicit interface between modules.
> 
> So, I have two propositions. What do you think ?
> 
> (1) The part of macros' implementation should be enclosed by tags of <interface>.
>      If you intend to manage the reference policy modules by XML database in future,
>      managing the whole of interface is better than only description, I think.

I don't understand the reason for your suggestion.  The XML is mainly
for documentation purposes.

> (2) I want to contain lang="XXXX" in the description field for internationalization.
>      By default, that should be writen in English, and opitionally taking out the description
>      field writen in Japanese and so on will be useful for non-native English user.

We haven't done much thought about internationalization yet, since its a
challenge to get high quality documentation in English in the first
place.  The attribute would probably be better as lang="xx", e.g.,
lang="jp", so its standardized.  Then in the future tools can easily get
the right language.

> # Please set your encoding to UTF-8.

I don't know much about encodings, but apparently editors (I tried vim
and gedit) will save it as ASCII if there are no non-ASCII characters,
even if you explicitly set UTF-8.

> --[ e.g ]--------------------------------
> ## <description>
> ##      <p>
> ##      This module contains basic filesystem types and interfaces. This
> ##      includes:
> ##      <ul>
> ##              <li>The concept of different file types including basic
> ##              files, mount points, tmp files, etc.</li>
> ##              <li>Access to groups of files and all files.</li>
> ##              <li>Types and interfaces for the basic filesystem layout
> ##              (/, /etc, /tmp, /usr, etc.).</li>
> ##      </ul>
> ##      </p>
> ## </description>
> ## <description lang="Japanese">
> ##	<p>
> ##	このモジュールは以下のファイルシステム用タイプとインターフェースを含みます。
> ##	<ul>
> ##		<li>通常ファイル、マウントポイント、一時ファイルなど異なったファイル
> ##		タイプに対する基本概念</li>
> ##		<li>ファイルの集合および全体に対するアクセス</li>
> ##		<li>基本的なファイルシステム構造に対するタイプとインターフェース
> ##		(/, /etc, /tmp, /usr, etc.).</li>
> ##	</ul>
> ##	</p>
> ## </description>
> -----------------------------------------

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
