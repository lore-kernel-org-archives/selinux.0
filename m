Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2CHSB1h002079
 for <selinux@tycho.nsa.gov>; Thu, 12 Mar 2015 13:28:11 -0400
Received: by widem10 with SMTP id em10so34900422wid.2
 for <selinux@tycho.nsa.gov>; Thu, 12 Mar 2015 10:28:06 -0700 (PDT)
Message-ID: <5501CC8B.2040303@linaro.org>
Date: Thu, 12 Mar 2015 17:27:39 +0000
From: Julien Grall <julien.grall@linaro.org>
MIME-Version: 1.0
To: Daniel De Graaf <dgdegra@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [Xen-devel] [PATCH 2/4] Add device tree ocontext nodes to Xen
 policy
References: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
 <1426180350-16259-3-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426180350-16259-3-git-send-email-dgdegra@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Daniel,

On 12/03/15 17:12, Daniel De Graaf wrote:
>  		        ;
> +dtree_context_def	: DEVICETREECON path security_context_def
> +		        {if (define_devicetree_context()) return -1;}
> +		        ;

The regex for matching the device tree path is different from a path.

the pathname convention is:

node-name@unit-address

The characters allowed for node-name/unit-name are:
	0-9 a-z A-Z , . _ + -

Although the @unit-address may be ommitted.

So the regex should be something like:
"/"({alnum}|['\._\+\-@])*

Regards,

-- 
Julien Grall
