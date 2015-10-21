Subject: Re: [PATCH] libselinux: Replace selabel_digest hash function
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1445441731-14343-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5627EC49.8030802@tycho.nsa.gov>
Date: Wed, 21 Oct 2015 15:49:29 -0400
MIME-Version: 1.0
In-Reply-To: <1445441731-14343-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/21/2015 11:35 AM, Richard Haines wrote:
> This replaces the openssl library with SHA1 hash functions
> extracted from [1] as this is a public domain implementation.
>
> util/selabel_digest -v option still compares the result with
> the openssl command "openssl dgst -sha1 -hex .." for validation.
>
> [1] https://github.com/WaterJuice/CryptLib
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Need to hide the symbols defined by sha1.c or they'll be exported by 
libselinux.
