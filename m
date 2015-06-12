Message-ID: <557AD3F0.1060909@tycho.nsa.gov>
Date: Fri, 12 Jun 2015 08:43:28 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Albert <danalbert@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix -Wreturn-type issues.
References: <CAFVaGhtDWzjpa+w0k6ktUWj5aBT3vQ-v5zAuhwNFrpvWA_APrQ@mail.gmail.com>
In-Reply-To: <CAFVaGhtDWzjpa+w0k6ktUWj5aBT3vQ-v5zAuhwNFrpvWA_APrQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: Elliott Hughes <enh@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/11/2015 07:47 PM, Dan Albert wrote:
> assert() only prevents -Wreturn-type from firing if asserts are
> enabled. Use abort() so we don't do unexpected things even if we use
> -UNDEBUG.

Thanks, applied.
