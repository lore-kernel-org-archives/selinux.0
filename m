Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GDwtgA000344
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 09:58:56 -0400 (EDT)
Received: from www346.sakura.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GDoDZm019915
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 13:50:16 GMT
Message-ID: <42B18324.6020502@kaigai.gr.jp>
Date: Thu, 16 Jun 2005 22:48:20 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ANN: SELinux Reference Policy Release
References: <1118871745.18294.28.camel@sgc.columbia.tresys.com>
In-Reply-To: <1118871745.18294.28.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I looked the SELinux Reference Policy lightly.
I prefer such the approach defines explicit interface between modules.

So, I have two propositions. What do you think ?

(1) The part of macros' implementation should be enclosed by tags of <interface>.
     If you intend to manage the reference policy modules by XML database in future,
     managing the whole of interface is better than only description, I think.
--[ e.g ]--------------------------------
########################################
## <interface name="domain_kill_all_domains">
##      <description>
##              Send a kill signal to all domains.
##      </description>
##      <parameter name="domain">
##              The type of the process performing this action.
##      </parameter>
# <implementation>  <-- Add one
define(`domain_kill_all_domains',`
         gen_require(`$0'_depend)

         allow $1 domain:process sigkill;
         allow $1 self:capability kill;
')
          :
#  </implementation> <-- Add one
## </interface>
------------------------------------------

(2) I want to contain lang="XXXX" in the description field for internationalization.
     By default, that should be writen in English, and opitionally taking out the description
     field writen in Japanese and so on will be useful for non-native English user.

# Please set your encoding to UTF-8.
--[ e.g ]--------------------------------
## <description>
##      <p>
##      This module contains basic filesystem types and interfaces. This
##      includes:
##      <ul>
##              <li>The concept of different file types including basic
##              files, mount points, tmp files, etc.</li>
##              <li>Access to groups of files and all files.</li>
##              <li>Types and interfaces for the basic filesystem layout
##              (/, /etc, /tmp, /usr, etc.).</li>
##      </ul>
##      </p>
## </description>
## <description lang="Japanese">
##	<p>
##	このモジュールは以下のファイルシステム用タイプとインターフェースを含みます。
##	<ul>
##		<li>通常ファイル、マウントポイント、一時ファイルなど異なったファイル
##		タイプに対する基本概念</li>
##		<li>ファイルの集合および全体に対するアクセス</li>
##		<li>基本的なファイルシステム構造に対するタイプとインターフェース
##		(/, /etc, /tmp, /usr, etc.).</li>
##	</ul>
##	</p>
## </description>
-----------------------------------------

Thanks,

Christopher J. PeBenito wrote:
> The first release of the SELinux Reference Policy is now available on
> Sourceforge from http://serefpolicy.sourceforge.net.
> 
> This is an experimental release, and definitely is not usable as a
> drop-in replacement for the current policy, as it can only boot a very
> limited RHEL4 system.  It is directed towards policy developers, to
> generate community feedback and discussion.
> 
> Any feedback is welcome.

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
