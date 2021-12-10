Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8B6C433F5
	for <selinux@archiver.kernel.org>; Fri, 10 Dec 2021 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhLJQRp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Dec 2021 11:17:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52698 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbhLJQRo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Dec 2021 11:17:44 -0500
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id E85B120B7179;
        Fri, 10 Dec 2021 08:14:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E85B120B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639152849;
        bh=aA7gWRimd8MP3fgZHlIka0kAQzr4sbR3jKnipUVXh8I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iDids8QkP01pfKn+TxTnAk/mvJaDJOkxeFB5wlMddnc9uHVloHIiVCte9NsH+d1OO
         VoCHPq+IuGm2RDBdzIDVsqlGiChbMqUyac6x4xxE8c+PWOXWEtelquMK8lBfqgp5Ya
         AH5xBh5X2prPn027ONYan3IVzATCkT3DOWR57TfI=
Message-ID: <95acdf19-b66a-bcbd-6cbc-7eadebfdfb61@linux.microsoft.com>
Date:   Fri, 10 Dec 2021 11:14:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/4] SELinux Notebook: Add eBook reader build
Content-Language: en-US
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20211210114340.13977-1-richard_c_haines@btinternet.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20211210114340.13977-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/2021 6:43 AM, Richard Haines wrote:
> This allows an eBook to be built that can be read by readers such as
> Bookworm and Foliate. Note that Bookworm does not render tables or examples
> very well, whereas Foliate does.
> 
> As eBooks use a different cover format the current SELinux penguin
> has been replaced with one from the SELinux artwork repository.
> 
> Richard Haines (4):
>    selinux-notebook: Make file links consistent
>    src/images: Remove current penguin
>    src/images: Add new SELinux penguin
>    selinux-notebook: Add epub build
> 
>   BUILD.md                           |  17 +-
>   CONTRIBUTING.md                    |  10 +-
>   Makefile                           |  48 +++-
>   README.md                          |   9 +-
>   src/bounds_rules.md                |   2 +-
>   src/cil_overview.md                |   2 +-
>   src/cover.md                       |  16 ++
>   src/cover_epub.md                  |   2 +
>   src/embedded_systems.md            |  12 +-
>   src/images/selinux-penguin.svg     | 398 -----------------------------
>   src/images/selinux-penguin_400.png | Bin 0 -> 65728 bytes
>   src/network_support.md             |   4 +-
>   src/postgresql.md                  |   6 +-
>   src/styles_epub.css                |  44 ++++
>   src/title.md                       |  16 --
>   src/toc.md                         |   2 +-
>   16 files changed, 139 insertions(+), 449 deletions(-)
>   create mode 100644 src/cover.md
>   create mode 100644 src/cover_epub.md
>   delete mode 100644 src/images/selinux-penguin.svg
>   create mode 100644 src/images/selinux-penguin_400.png
>   create mode 100644 src/styles_epub.css
> 

Applying these patches (and subbing in a random png for the penguin 
cover image since you obviously didn't include the binary diff on the 
list) allows me to successfully build an epub and load it using the 
Overdrive app on my Android device.  Everything I poked at generally 
worked fine, although long lines overrun really awkwardly, which is 
particularly an issue for tables.  For example, the table in the SELinux 
Overview section overruns the next several pages and make the whole 
thing very hard to read.  I'm not sure if thats may pandadoc version, my 
epub reader, or just basic difficulties with table rendering in epub.

It might also be nice to populate the epub metadata.

Tested-by: Daniel Burgener <dburgener@linux.microsoft.com>
