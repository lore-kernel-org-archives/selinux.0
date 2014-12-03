Message-ID: <547F2353.9010501@tycho.nsa.gov>
Date: Wed, 03 Dec 2014 09:50:59 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix expand logic for policy versions older than 24.
References: <1416841579-7924-1-git-send-email-sds@tycho.nsa.gov>
 <54735BC4.7050207@tresys.com> <5474D17F.5060008@tycho.nsa.gov>
 <547C8D15.1080807@tresys.com>
In-Reply-To: <547C8D15.1080807@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/01/2014 10:45 AM, Steve Lawrence wrote:
> I'm fine including it in 2.4.
> 
> I'm unclear on next versus master as well. Not sure what the original
> intention was. I feel like there are not really that many incoming
> patches (aside from the recent CIL changes) to really necessitate a
> next/master branch split. And there's only one small patch on #next,
> which I don't have a problem including in 2.4 as well--there's going to
> be at least one more release candidate.

Ok, both changes cherry-picked onto master; next deleted.
