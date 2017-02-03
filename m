Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v13JHTTg018004
 for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2017 14:17:29 -0500
Subject: Re: [PATCH 0/5] checkpolicy: Cleanup declare and require functions
To: selinux@tycho.nsa.gov
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <2919ffaf-aa25-fa50-21c5-867878274342@tycho.nsa.gov>
Date: Fri, 3 Feb 2017 14:17:48 -0500
MIME-Version: 1.0
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/31/2017 02:41 PM, James Carter wrote:
> Cleanup declare and require functions in module_compiler.c to improve
> maintainability and clarity. Functionality is not changed.
>
> James Carter (5):
>   checkpolicy: Create common function for type declares and requires
>   checkpolicy: Create common function for role declares and requires
>   checkpolicy: Create common function for user declares and requires
>   checkpolicy: Cleanup error messages
>   checkpolicy: Move common require and declare code into new function
>
>  checkpolicy/module_compiler.c | 892 +++++++++++++++++++-----------------------
>  1 file changed, 395 insertions(+), 497 deletions(-)
>

Merged this series with the one change of making all the create_*() functions 
static.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
