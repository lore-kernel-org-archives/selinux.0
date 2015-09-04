Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t843F5bh008052
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 23:15:05 -0400
Received: by pacwi10 with SMTP id wi10so9944643pac.3
 for <selinux@tycho.nsa.gov>; Thu, 03 Sep 2015 20:15:03 -0700 (PDT)
Date: Fri, 4 Sep 2015 11:14:59 +0800
From: Jason Zaman <jason@perfinion.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: save homedir_template in the policy store
 for genhomedircon
Message-ID: <20150904031459.GA8559@meriadoc.omgwtfbbq>
References: <1441293481-13903-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441293481-13903-1-git-send-email-slawrence@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 03, 2015 at 11:18:01AM -0400, Steve Lawrence wrote:
> We don't currently store homedir_template in the policy store, which
> means genhomedircon only has a template file to use if the
> homedir_template was generated from the file contexts in the same
> transaction.  But homedir_template isn't always generated, as in the
> case with setsebool -P. In this and other cases, genhomedircon will not
> have a template file resulting in an empty file_contexts.homedir file.
> 
> This commit changes this so that homedir_template is always stored in
> the policy store so it can be used by genhomedircon regardless of how
> policy was built. Also add the homedir_template file to the migration
> script.
> 
> Signed-off by: Steve Lawrence <slawrence@tresys.com>

This does indeed fix my problem. Thanks for the quick fix!
I have backported the patch to gentoo. It seems fairly important so i'd
recommend any other distros on 2.4 do that too. I locked myself out of
one of my machines once :(

Tested by: Jason Zaman <jason@perfinion.com>
