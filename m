Subject: Re: [PATCH 1/6] restorecond: add noreturn attribute to exitApp()
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170305171305.23170-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <0d740d76-a9a5-9cf2-3288-f1e5cfd34e05@tycho.nsa.gov>
Date: Tue, 7 Mar 2017 14:23:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170305171305.23170-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/05/2017 12:13 PM, Nicolas Iooss wrote:
> This makes it possible for static analyzers such as clang's one to
> understand that strings_list_add() cannot dereference a NULL pointer in
> the following code:
>
>     if (!newptr)
>         exitApp("Out of Memory");
>     newptr->string = strdup(string);
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I applied these six patches.

Thanks,
Jim

> ---
>  restorecond/restorecond.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/restorecond/restorecond.h b/restorecond/restorecond.h
> index a6be584c84a5..db7e50f72d2d 100644
> --- a/restorecond/restorecond.h
> +++ b/restorecond/restorecond.h
> @@ -33,7 +33,7 @@ extern int run_as_user;
>  extern int start(void);
>  extern int server(int, const char *watch_file);
>
> -extern void exitApp(const char *msg);
> +extern void exitApp(const char *msg) __attribute__((__noreturn__));
>  extern void read_config(int fd,	const char *watch_file);
>
>  extern int watch(int fd, const char *watch_file);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
