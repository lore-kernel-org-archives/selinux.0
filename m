Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93KJkFs001413
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 16:19:46 -0400
Received: by mail-pf0-f173.google.com with SMTP id s13so67193272pfd.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 13:19:22 -0700 (PDT)
Subject: Re: [PATCH] libsepol: Add support for converting extended permissions
 to CIL
To: selinux@tycho.nsa.gov
References: <1475524323-29138-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Daniel Cashman <dcashman@android.com>
Message-ID: <4c4b598f-9790-a3dd-325c-37bdabcfa809@android.com>
Date: Mon, 3 Oct 2016 13:19:20 -0700
MIME-Version: 1.0
In-Reply-To: <1475524323-29138-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/03/2016 12:52 PM, James Carter wrote:
> Checkpolicy has an option to produce CIL output and is dependent on
> the policydb-to-CIL conversion in libsepol for that option. Add
> support for converting extended permissions to CIL so that checlpolicy
> can generate CIL.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

I had a bug open for this, thank you! +jeffv@google.com who was looking
into it.

-Dan
